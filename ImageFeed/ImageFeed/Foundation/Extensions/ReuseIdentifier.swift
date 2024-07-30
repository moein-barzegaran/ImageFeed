//
//  ReuseIdentifier.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import UIKit

protocol ReuseIdentifier {
    static var identifier: String { get }
}

extension ReuseIdentifier {
    static var identifier: String {
        String(describing: Self.self)
    }
}

extension UICollectionViewCell: ReuseIdentifier {}
