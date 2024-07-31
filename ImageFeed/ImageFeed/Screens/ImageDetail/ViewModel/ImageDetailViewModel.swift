//
//  ImageDetailViewModel.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/31/24.
//

import UIKit

protocol ImageDetailViewModelDelegate: AnyObject {
    func imageLoaded(_ image: UIImage)
}

class ImageDetailViewModel {

    private let imageItemData: ImageItem
    weak var imageLoader: ImageLoader?
    weak var delegate: ImageDetailViewModelDelegate?

    init(
        imageItemData: ImageItem,
        imageLoader: ImageLoader
    ) {
        self.imageItemData = imageItemData
        self.imageLoader = imageLoader
    }

    func onAppearAction() {
        fetchImageFeed()
    }

    private func fetchImageFeed() {
        guard let originalUrl = URL(string: imageItemData.data.original) else { return }

        Task { [weak self] in
            guard let self else { return }
            do {
                guard let image = try await self.imageLoader?.fetch(originalUrl) else { return }

                DispatchQueue.main.async {
                    self.delegate?.imageLoaded(image)
                }
            } catch {
                print(error)
            }
        }
    }
}
