//
//  ImageFeedViewController.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import UIKit

final class ImageFeedViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = dataSource
        collectionView.register(ImageItemCell.self, forCellWithReuseIdentifier: ImageItemCell.identifier)
        return collectionView
    }()

    private let layout: UICollectionViewLayout
    private let dataSource: ImageFeedDataSource

    // MARK: - Initializers

    init(
        layout: UICollectionViewLayout,
        dataSource: ImageFeedDataSource
    ) {
        self.layout = layout
        self.dataSource = dataSource

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View LifeCycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Private Methods

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DefaultSpacing.space16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DefaultSpacing.space16),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: DefaultSpacing.space16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -DefaultSpacing.space16)
        ])
    }
}

