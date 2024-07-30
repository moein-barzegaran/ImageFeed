//
//  ImageFeedService.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import Foundation

protocol ImageFeedService {
    func fetchImagesList(page: Int, itemPerPage: Int) async -> Result<ImageFeedResponse, RequestError>
}

struct ImageFeedDataService: HTTPClient, ImageFeedService {
    func fetchImagesList(page: Int, itemPerPage: Int) async -> Result<ImageFeedResponse, RequestError> {
        return await sendRequest(
            endpoint: ImageFeedEndpoint.fetchList(page: page, itemPerPage: itemPerPage),
            responseModel: ImageFeedResponse.self
        )
    }
}
