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
            // Helper
            var image: UIImage?

            defer {
                // Execute Handler on Main Thread
                DispatchQueue.main.async {
                    // Execute Handler
                    completion(image)
                }
            }

            if let data = data {
                // Create Image from Data
                image = UIImage(data: data)
            }
        }

        // Resume Data Task
        dataTask.resume()

        return dataTask
    }
}

// MARK: - URLSessionTask + Cancellable

extension URLSessionTask: Cancellable {}
