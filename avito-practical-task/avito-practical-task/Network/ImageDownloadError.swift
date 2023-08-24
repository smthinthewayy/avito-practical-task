//
//  ImageDownloadError.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 24.08.2023.
//

import Foundation

enum ImageDownloadError: Error {
    case invalidURL
    case networkError(Error)
    case invalidImageData
}
