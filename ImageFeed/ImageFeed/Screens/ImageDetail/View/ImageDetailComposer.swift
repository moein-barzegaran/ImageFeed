//
//  ImageDetailComposer.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/31/24.
//

import UIKit

struct ImageDetailComposer {
    static func compose(imageData: ImageItem, imageLoader: ImageLoader) -> ImageDetailViewController {
        let viewModel = ImageDetailViewModel(
            imageItemData: imageData,
            imageLoader: imageLoader
        )

        let vc = ImageDetailViewController(viewModel: viewModel)

        // Set delegates
        viewModel.delegate = vc

        return vc
    }
}

