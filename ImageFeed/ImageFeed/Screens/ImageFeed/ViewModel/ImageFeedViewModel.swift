//
//  ImageFeedViewModel.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import Foundation

protocol ImageFeedViewModelDelegate: AnyObject {
    func reloadData()
    func insertRows(range: Range<Int>)
}

final class ImageFeedViewModel {
    
    enum Constants {
        static let itemInPage = 15
    }

    weak var delegate: ImageFeedViewModelDelegate?

    var triggerPointForNextPage: Int {
        var total: Int
        if currentPageNumber == 0 { total = Constants.itemInPage }
        total = currentPageNumber * Constants.itemInPage
        return total - 3
    }

    var imagesList: [ImageItem] = []
    var imageLoader = ImageLoader()

    private var numberOfItemPerPage = Constants.itemInPage
    private var currentPageNumber: Int = 0
    private var totalResults: Int = 1000

    private let service: ImageFeedService

    // MARK: Initializer

    init(
        service: ImageFeedService
    ) {
        self.service = service
    }

    func onAppearAction() {
        fetchImageFeed()
    }

    func pullToRefreshAction() {
        Task { [weak self] in
            await self?.imageLoader.clearCache()
        }
        currentPageNumber = .zero
        fetchImageFeed()
    }

    func fetchNextPage() {
        fetchImageFeed()
    }

    private func fetchImageFeed() {
        Task { [weak self] in
            guard let self else { return }
            guard currentPageNumber * Constants.itemInPage <= totalResults else { return }

            let response = await service.fetchImagesList(
                page: currentPageNumber + 1,
                itemPerPage: Constants.itemInPage
            )

            switch response {
            case .success(let data):
                self.totalResults = data.totalResults
                self.currentPageNumber = data.page

                let photos = data.photos.map({ $0.toDomain() })
                guard !photos.isEmpty else { return }

                if self.currentPageNumber == 1 {
                    self.imagesList = photos
                    self.delegate?.reloadData()
                } else {
                    let firstIndexToInsert = self.imagesList.count
                    self.imagesList.append(contentsOf: photos)
                    self.delegate?.insertRows(range: (firstIndexToInsert..<self.imagesList.count))
                }

            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
