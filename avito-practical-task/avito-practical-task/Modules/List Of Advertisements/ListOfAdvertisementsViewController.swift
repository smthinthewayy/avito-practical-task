//
//  ListOfProductsViewController.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 24.08.2023.
//

import CocoaLumberjackSwift
import SkeletonView
import UIKit

// MARK: - ListOfAdvertisementsViewController

class ListOfAdvertisementsViewController: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataForAdvertisementCollectionView()
    }

    // MARK: Private

    private var advertisements: Advertisements = Advertisements(advertisements: []) {
        didSet {
            advertisementCollectionView.reloadData()
            advertisementCollectionView.isHidden = advertisements.advertisements.isEmpty
        }
    }

    private let advertisementCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(AdvertisementCollectionViewCell.self, forCellWithReuseIdentifier: "AdvertisementCollectionViewCell")

        return collectionView
    }()

    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(advertisementCollectionView)
        title = "Рекомендации"

        NSLayoutConstraint.activate([
            advertisementCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            advertisementCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            advertisementCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            advertisementCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        advertisementCollectionView.dataSource = self
        advertisementCollectionView.delegate = self
    }

    private func fetchDataForAdvertisementCollectionView() {
        NetworkManager.shared.getAdvertisements { [weak self] result in
            switch result {
            case let .success(advertisements):
                self?.advertisements = NetworkConverter.shared.fromNetworkAdvertisementsToAdvertisements(advertisements)
                self?.setupUI()
            case let .failure(error):
                DDLogError("\(error)")
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ListOfAdvertisementsViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return advertisements.advertisements.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "AdvertisementCollectionViewCell", for: indexPath) as? AdvertisementCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.setupSubviews(advertisements.advertisements[indexPath.row])

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ListOfAdvertisementsViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let advertisementDetailsVC = AdvertisementDetailsViewController()
        advertisementDetailsVC.advertisementID = advertisements.advertisements[indexPath.row].id
        navigationController?.pushViewController(advertisementDetailsVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ListOfAdvertisementsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (advertisementCollectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size + (size * 0.6))
    }
}

// MARK: - CommentFlowLayout

final class CommentFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributesObjects = super.layoutAttributesForElements(in: rect)?.map { $0.copy() } as? [UICollectionViewLayoutAttributes]
        layoutAttributesObjects?.forEach { layoutAttributes in
            if layoutAttributes.representedElementCategory == .cell {
                if let newFrame = layoutAttributesForItem(at: layoutAttributes.indexPath)?.frame {
                    layoutAttributes.frame = newFrame
                }
            }
        }
        return layoutAttributesObjects
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView else { fatalError() }
        guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
            return nil
        }

        layoutAttributes.frame.origin.x = sectionInset.left
        layoutAttributes.frame.size.width = collectionView.safeAreaLayoutGuide.layoutFrame.width - sectionInset.left - sectionInset.right
        return layoutAttributes
    }
}
