//
//  ImageDataDTO.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import Foundation

struct ImageDataDTO: Decodable {
    let original: String
    let portrait: String
}

extension ImageDataDTO {
    func toDomain() -> ImageData {
        ImageData(
            original: original,
            portrait: portrait
        )
    }
}
