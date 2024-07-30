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
    
    weak var delegate: ImageFeedViewModelDelegate?
}
