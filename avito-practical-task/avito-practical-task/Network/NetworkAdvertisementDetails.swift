//
//  NetworkAdvertisementDetails.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 24.08.2023.
//

import Foundation

struct NetworkAdvertisementDetails: Codable {
    var id: String
    var title: String
    var price: String
    var location: String
    var imageURL: String
    var createdDate: String
    var description: String
    var email: String
    var phoneNumber: String
    var address: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case location
        case imageURL = "image_url"
        case createdDate = "created_date"
        case description
        case email
        case phoneNumber = "phone_number"
        case address
    }
}
