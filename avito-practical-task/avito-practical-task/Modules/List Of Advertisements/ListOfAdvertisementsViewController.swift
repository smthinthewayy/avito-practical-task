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
        configureCollectionView()
        configureDataSource()
        fetchDataForAdvertisementCollectionView()
    }

    // MARK: Private

    private typealias AdvertisementDataSource = UICollectionViewDiffableDataSource<Section, Advertisement>

    private enum Section {
        case main
    }

    private var advertisements: Advertisements = .init(advertisements: [])

    private var collectionView: UICollectionView?

    private var dataSource: AdvertisementDataSource?

    private lazy var customFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        let width = view.bounds.width
        let padding: CGFloat = 16
        let minimumItemSpacing: CGFloat = 8
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 2
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + (itemWidth * 0.6))
        return flowLayout
    }()

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Рекомендации"
        collectionView?.delegate = self
    }

    private func fetchDataForAdvertisementCollectionView() {
        NetworkManager.shared.getAdvertisements { [weak self] result in
            switch result {
            case let .success(advertisements):
                self?.advertisements = NetworkConverter.shared.fromNetworkAdvertisementsToAdvertisements(advertisements)
                self?.updateData()
                self?.setupUI()
            case let .failure(error):
                DDLogError("\(error)")
            }
        }
    }
}

// MARK: - DataSource

extension ListOfAdvertisementsViewController {
    private func configureDataSource() {
        guard let collectionView = collectionView else { return }
        dataSource = AdvertisementDataSource(collectionView: collectionView,
                                             cellProvider: { collectionView, indexPath, advertisement -> UICollectionViewCell? in
                                                 let cell = collectionView.dequeueReusableCell(
                                                     withReuseIdentifier: AdvertisementCollectionViewCell.reuseIdentifier,
                                                     for: indexPath
                                                 ) as? AdvertisementCollectionViewCell
                                                 cell?.setupSubviews(advertisement)
                                                 return cell
                                             })
    }

    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Advertisement>()
        snapshot.appendSections([.main])
        snapshot.appendItems(advertisements.advertisements)
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: - CollectionView

extension ListOfAdvertisementsViewController {
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: customFlowLayout)
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
        collectionView.register(AdvertisementCollectionViewCell.self, forCellWithReuseIdentifier: AdvertisementCollectionViewCell.reuseIdentifier)
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
