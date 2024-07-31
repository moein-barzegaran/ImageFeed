//
//  ImageLoader.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import UIKit

actor ImageLoader {
    enum LoaderStatus {
        case inProgress(Task<UIImage, Error>)
        case fetched(UIImage)
    }

    private let imageCache = NSCache<AnyObject, AnyObject>()

    private var images: [URLRequest: LoaderStatus] = [:]

    func fetch(_ url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)
        return try await fetch(request)
    }

    func clearCache() {
        imageCache.removeAllObjects()
    }

    private func fetch(_ urlRequest: URLRequest) async throws -> UIImage {
        if let status = images[urlRequest] {
            switch status {
            case .fetched(let image):
                return image
            case .inProgress(let task):
                return try await task.value
            }
        }

        if let image = self.retrieveImage(from: urlRequest) {
            images[urlRequest] = .fetched(image)
            return image
        }

        let task: Task<UIImage, Error> = Task {
            let (imageData, _) = try await URLSession.shared.data(
                for: urlRequest
            )
            let image = UIImage(data: imageData)!
            self.persistImage(image, for: urlRequest)
            return image
        }

        images[urlRequest] = .inProgress(task)

        let image = try await task.value

        images[urlRequest] = .fetched(image)

        return image
    }

    private func persistImage(_ image: UIImage, for urlRequest: URLRequest) {
        if let absoluteString = urlRequest.url?.path() {
            imageCache.setObject(image, forKey: NSString(string: absoluteString))
        }
    }

    private func retrieveImage(from urlRequest: URLRequest) -> UIImage? {
        guard let absoluteString = urlRequest.url?.path() else { return nil }
        return imageCache.object(forKey: NSString(string: absoluteString)) as? UIImage
    }
}
