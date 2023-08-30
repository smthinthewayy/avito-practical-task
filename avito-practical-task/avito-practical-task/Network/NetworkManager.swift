//
//  NetworkManager.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 24.08.2023.
//

import CocoaLumberjackSwift
import Foundation

// MARK: - NetworkManager

final class NetworkManager {
    // MARK: Lifecycle

    private init() {}

    // MARK: Public

    public func getAdvertisements(completion: @escaping (Result<NetworkAdvertisements, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("main-page.json")
        request(url: url, completion: completion)
    }

    public func getAdvertisementDetails(for id: String, completion: @escaping (Result<NetworkAdvertisementDetails, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("details/\(id).json")
        request(url: url, completion: completion)
    }

    // MARK: Internal

    static let shared = NetworkManager()

    let baseURL: URL = .init(string: "https://www.avito.st/s/interns-ios/")!

    // MARK: Private

    private let decoder = JSONDecoder()

    private func request<T>(url: URL, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        let request = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 2

        let session = URLSession(configuration: config)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                DDLogError("Возможно отсутствует подключение к сети или происходит проблема с установлением соединения с сервером")
                DDLogError("\(error)")
                if (error as NSError).code == NSURLErrorTimedOut {
                    let timeoutError = NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil)
                    DispatchQueue.main.async {
                        completion(.failure(timeoutError))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DDLogError("response не может быть приведен к типу ﻿HTTPURLResponse")
                DispatchQueue.main.async {
                    completion(.failure(URLError(.badServerResponse)))
                }
                return
            }

            let statusCode = httpResponse.statusCode

            guard (200 ..< 300).contains(statusCode) else {
                let errorDescription = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                let userInfo = [NSLocalizedDescriptionKey: errorDescription]
                let httpError = NSError(domain: "HTTP", code: statusCode, userInfo: userInfo)
                print()
                DDLogError("HTTP-статус код ответа на запрос не находится в диапазоне успешных (200-299)")
                DispatchQueue.main.async {
                    completion(.failure(httpError))
                }
                return
            }

            if let data = data {
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let parsedData = try self.decoder.decode(T.self, from: data)
                    DDLogInfo("Данные были успешно преобразованы в указанный тип ﻿\(T.self)")
                    DispatchQueue.main.async {
                        completion(.success(parsedData))
                    }
                } catch {
                    DDLogError("Ошибка при попытке декодировать ﻿data в указанный тип ﻿\(T.self)")
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }

        task.resume()
    }
}
