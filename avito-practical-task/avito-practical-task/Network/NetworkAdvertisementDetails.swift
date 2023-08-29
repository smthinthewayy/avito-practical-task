//
//  NetworkAdvertisementDetails.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 24.08.2023.
//

import Foundation

struct NetworkAdvertisementDetails: Decodable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: String
    let createdDate: String
    let description: String
    let email: String
    let phoneNumber: String
    let address: String
}
