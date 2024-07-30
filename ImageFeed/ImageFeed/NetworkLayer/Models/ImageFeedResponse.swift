//
//  ImageFeedResponse.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import Foundation

struct ImageFeedResponse: Decodable {
    let page: Int
    let perPage: Int
    let totalResults: Int
    let photos: [ImageItemDTO]

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalResults = "total_results"
        case photos
    }
}
