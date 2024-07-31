//
//  ImageItemCell.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import UIKit

final class ImageItemCell: UICollectionViewCell {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = DefaultRadius.radius8
        imageView.clipsToBounds = true
        return imageView
    }()

    var imageItemData: ImageItem? {
        didSet {
            updateUI()
        }
    }

    weak var imageLoader: ImageLoader?

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        imageItemData = nil
        imageView.image = nil
    }

    // MARK: - Private methods

    private func setupViews() {
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func updateUI() {
        Task(priority: .background) { [weak self] in
            guard let self else { return }
            guard let imageItemData, let imageURL = URL(string: imageItemData.data.portrait) else { return }
            do {
                let image = try await self.imageLoader?.fetch(imageURL)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            } catch {
                print(error)
            }
        }
    }
}
