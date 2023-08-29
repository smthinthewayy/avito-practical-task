//
//  Advertisement.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 24.08.2023.
//

import UIKit

struct Advertisement: Hashable {
    var id: String
    var title: String
    var price: String
    var location: String
    var imageURL: URL
    var createdDate: Date
}
