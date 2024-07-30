//
//  ImageFeedViewModel.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import Foundation

protocol ImageFeedViewModelDelegate: AnyObject {

}

final class ImageFeedViewModel {
    
    enum Constants {
        static let itemInPage = 15
    }

    weak var delegate: ImageFeedViewModelDelegate?

    private let service: ImageFeedService

    private var numberOfItemPerPage = Constants.itemInPage
    private var currentPageNumber: Int = 0
    private var totalResults: Int = 1000
    private var imagesList: [ImageItem] = []

    // MARK: Initializer

    init(
        service: ImageFeedService
    ) {
        self.service = service
    }

    func onAppearAction() {
        fetchImageFeed()
    }

    func fetchImageFeed() {
        Task { [weak self] in
            guard let self else { return }

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
                } else {
                    self.imagesList.append(contentsOf: photos)
                }

            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
