//
//  ImageFeedDataSource.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import UIKit

final class ImageFeedDataSource: NSObject {

}

extension ImageFeedDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageItemCell.identifier, for: indexPath)
        return cell
    }


}
