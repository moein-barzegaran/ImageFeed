//
//  ImageFeedComposer.swift
//  ImageFeed
//
//  Created by Moein Barzegaran on 7/30/24.
//

import UIKit

struct ImageFeedComposer {
    static func compose() -> ImageFeedViewController {
        ImageFeedViewController(layout: makeLayout(), dataSource: makeDataSource())
    }

    private static func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let itemsPerRow = sectionIndex + 3
            let fraction: CGFloat = 1 / CGFloat(itemsPerRow)
            let inset: CGFloat = 2.5

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

            // Supplementary Item
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
            section.boundarySupplementaryItems = [headerItem]

            return section
        })
    }

    private static func makeDataSource() -> ImageFeedDataSource {
        ImageFeedDataSource()
    }
}
