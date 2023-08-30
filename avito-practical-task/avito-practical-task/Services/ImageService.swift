//
//  ImageService.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 29.08.2023.
//

import UIKit

// MARK: - Cancellable

protocol Cancellable {
    func cancel()
}

// MARK: - ImageService

final class ImageService {
    func image(for url: URL, completion: @escaping (UIImage?) -> Void) -> Cancellable {
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            var image: UIImage?

            defer {
                DispatchQueue.main.async {
                    completion(image)
                }
            }

            if let data = data {
                image = UIImage(data: data)
            }
        }

        dataTask.resume()

        return dataTask
    }
}

// MARK: - URLSessionTask + Cancellable

extension URLSessionTask: Cancellable {}
