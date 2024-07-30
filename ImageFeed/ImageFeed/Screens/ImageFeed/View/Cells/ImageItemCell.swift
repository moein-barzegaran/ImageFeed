//
//  ImageItemCell.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import UIKit

final class ImageItemCell: UICollectionViewCell {

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupViews() {
        contentView.backgroundColor = .red
    }
}
