//
//  ImageFeedComposer.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import UIKit

struct ImageFeedComposer {
    static func compose() -> ImageFeedViewController {
        let viewModel = ImageFeedViewModel(service: ImageFeedDataService())
        let vc = ImageFeedViewController(
            layout: makeLayout(), 
            viewModel: viewModel
        )

        // Set delegates
        viewModel.delegate = vc

        return vc
    }

    private static func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let itemsPerRow = 2
            let fraction: CGFloat = 1 / CGFloat(itemsPerRow)
            let inset: CGFloat = 4

            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

            return section
        })
    }
}
