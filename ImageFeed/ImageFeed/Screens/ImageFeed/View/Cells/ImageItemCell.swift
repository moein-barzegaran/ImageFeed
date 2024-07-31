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

    private lazy var photographerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 11)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    private lazy var transparentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        view.layer.cornerRadius = DefaultRadius.radius8
        return view
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
        transparentContainerView.addSubview(photographerLabel)
        contentView.addSubview(transparentContainerView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            transparentContainerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            transparentContainerView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            transparentContainerView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),

            photographerLabel.topAnchor.constraint(equalTo: transparentContainerView.topAnchor, constant: DefaultSpacing.space8),
            photographerLabel.bottomAnchor.constraint(equalTo: transparentContainerView.bottomAnchor, constant: -DefaultSpacing.space8),
            photographerLabel.leadingAnchor.constraint(equalTo: transparentContainerView.leadingAnchor, constant: DefaultSpacing.space8),
            photographerLabel.trailingAnchor.constraint(equalTo: transparentContainerView.trailingAnchor, constant: -DefaultSpacing.space8)
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
                    self.photographerLabel.text = imageItemData.photographer
                }
            } catch {
                print(error)
            }
        }
    }
}
