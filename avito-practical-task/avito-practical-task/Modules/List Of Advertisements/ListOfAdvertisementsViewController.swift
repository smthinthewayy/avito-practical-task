//
//  ListOfProductsViewController.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 24.08.2023.
//

import CocoaLumberjackSwift
import UIKit

// MARK: - ListOfAdvertisementsViewController

class ListOfAdvertisementsViewController: UIViewController {
    private var advertisements: Advertisements?

    private let advertisementCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(AdvertisementCollectionViewCell.self, forCellWithReuseIdentifier: "AdvertisementCollectionViewCell")

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
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

    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(advertisementCollectionView)

        NSLayoutConstraint.activate([
            advertisementCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            advertisementCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            advertisementCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            advertisementCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        advertisementCollectionView.dataSource = self
        advertisementCollectionView.delegate = self
    }
}

// MARK: UICollectionViewDataSource

extension ListOfAdvertisementsViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        if let advertisements = advertisements {
            return advertisements.advertisements.count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "AdvertisementCollectionViewCell", for: indexPath) as? AdvertisementCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        if let advertisements = advertisements {
            cell.setupSubviews(advertisements.advertisements[indexPath.row])
        } else {
            cell.setupSubviews(Advertisement(
                id: "1",
                title: "Смартфон Apple iPhone 12 оригинал 100% клянусь мамой папой братом собакой",
                price: "55000 ₽",
                location: "Москва",
                imageURL: URL(string: "https://www.avito.st/s/interns-ios/images/1.png")!,
                createdDate: .now
            ))
        }

        return cell
    }
}

// MARK: UICollectionViewDelegate

extension ListOfAdvertisementsViewController: UICollectionViewDelegate {}

// MARK: UICollectionViewDelegateFlowLayout

extension ListOfAdvertisementsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let width: CGFloat = (advertisementCollectionView.frame.size.width - space) / 2.0
        return CGSize(width: width, height: 300)
    }
}
