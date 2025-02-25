//
//  ImageFeedViewController.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import UIKit

final class ImageFeedViewController: UIViewController {

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        return refreshControl
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        collectionView.register(ImageItemCell.self, forCellWithReuseIdentifier: ImageItemCell.identifier)
        return collectionView
    }()

    private let layout: UICollectionViewLayout
    private let viewModel: ImageFeedViewModel

    // MARK: - Initializers

    init(
        layout: UICollectionViewLayout,
        viewModel: ImageFeedViewModel
    ) {
        self.layout = layout
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View LifeCycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()

        viewModel.onAppearAction()
    }

    // MARK: - Private Methods

    private func setupViews() {

        title = "Image Feed"
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DefaultSpacing.space16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DefaultSpacing.space16),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: DefaultSpacing.space16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func pullToRefreshAction() {
        refreshControl.beginRefreshing()
        viewModel.pullToRefreshAction()
    }
}

// MARK: - ImageFeedViewModelDelegate

extension ImageFeedViewController: ImageFeedViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.collectionView.reloadData()
        }
    }

    func insertRows(range: Range<Int>) {
        let indexPathList = range.map({ IndexPath(row: $0, section: .zero )})
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.insertItems(at: indexPathList)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ImageFeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.imagesList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageItemCell.identifier,
            for: indexPath
        ) as? ImageItemCell else { return UICollectionViewCell() }
        cell.imageItemData = viewModel.imagesList[indexPath.row]
        cell.imageLoader = viewModel.imageLoader

        if indexPath.row == viewModel.triggerPointForNextPage {
            viewModel.fetchNextPage()
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageData = viewModel.imagesList[indexPath.row]
        let vc = ImageDetailComposer.compose(imageData: imageData, imageLoader: viewModel.imageLoader)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
