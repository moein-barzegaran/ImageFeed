//
//  ImageItem.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import Foundation

struct ImageItem {
    let id: Int
    let photographer: String
    let data: ImageData
}

struct ImageData {
    let original: String
    let portrait: String
}
