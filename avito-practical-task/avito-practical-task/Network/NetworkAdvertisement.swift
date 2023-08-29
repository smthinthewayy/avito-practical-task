//
//  NetworkAdvertisement.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 24.08.2023.
//

import Foundation

struct NetworkAdvertisement: Decodable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: String
    let createdDate: String
}
