//
//  ListOfProductsViewController.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 24.08.2023.
//

import UIKit

class ListOfProductsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let networkManager = NetworkManager()
        networkManager.getAdvertisements { result in
            switch result {
            case let .success(result):
                print(result)
            case let .failure(error):
                print(error)
            }
        }
//        networkManager.getAdvertisementDetails(for: "1") { result in
//            switch result {
//            case let .success(result):
//                print(result)
//            case let .failure(error):
//                print(error)
//            }
//        }
    }
}
