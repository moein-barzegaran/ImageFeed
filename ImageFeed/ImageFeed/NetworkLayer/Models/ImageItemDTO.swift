//
//  ImageItemDTO.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import Foundation

struct ImageItemDTO: Decodable {
    let id: Int
    let photographer: String
    let data: ImageDataDTO

    enum CodingKeys: String, CodingKey {
        case id
        case photographer
        case data = "src"
    }
}

extension ImageItemDTO {
    func toDomain() -> ImageItem {
        ImageItem(
            id: id,
            photographer: photographer,
            data: data.toDomain()
        )
    }
}
