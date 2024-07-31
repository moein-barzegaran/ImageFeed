//
//  ImageDetailViewController.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/31/24.
//

import UIKit

final class ImageDetailViewController: UIViewController {

    private let viewModel: ImageDetailViewModel

    init(viewModel: ImageDetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = DefaultRadius.radius8
        imageView.clipsToBounds = true
        return imageView
    }()

    // MARK: - View LifeCycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        viewModel.onAppearAction()
    }

    private func setupViews() {
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ImageDetailViewController: ImageDetailViewModelDelegate {
    func imageLoaded(_ image: UIImage) {
        imageView.image = image
    }
}
