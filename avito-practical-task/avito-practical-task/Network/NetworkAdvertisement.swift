//
//  NetworkAdvertisement.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 24.08.2023.
//

import Foundation

struct NetworkAdvertisement: Codable {
    var id: String
    var title: String
    var price: String
    var location: String
    var imageURL: String
    var createdDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}
