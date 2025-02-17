//
//  ImageFeedEndpoint.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import Foundation

struct APIKey {
    static let key = "XBlGheoHUQnHGOwlTBBUzwZIGfN2cTCxulh1huh6URzBWRBYUOwR4uKQ"
}

enum ImageFeedEndpoint {
    case fetchList(page: Int, itemPerPage: Int)
}

extension ImageFeedEndpoint: Endpoint {
    var path: String {
        switch self {
        case .fetchList:
            return "/v1/curated"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchList: return .get
        }
    }

    var header: [String: String]? {
        // Access Token to use in Bearer header
        switch self {
        case .fetchList:
            return ["Authorization": "\(APIKey.key)"]
        }
    }

    var queryItems: [String: String]? {
        switch self {
        case let .fetchList(page, itemPerPage):
            return [
                "page": "\(page)",
                "per_page": "\(itemPerPage)"
            ]
        }
    }

    var body: [String: String]? {
        switch self {
        case .fetchList: return nil
        }
    }
}
