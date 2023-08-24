//
//  ListOfProductsViewController.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 24.08.2023.
//

import UIKit

class ListOfAdvertisementsViewController: UIViewController {
    private var advertisements: Advertisements?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let networkManager = NetworkManager()
        networkManager.getAdvertisements { [weak self] result in
            switch result {
            case let .success(networkAdvertisements):
                self?.advertisements = NetworkConverter.shared.fromNetworkAdvertisementsToAdvertisements(networkAdvertisements)
                self?.setupView()
            case let .failure(error):
                print(error)
            }
        }
    }

    private func setupView() {
        view.backgroundColor = .systemPink
    }
}
