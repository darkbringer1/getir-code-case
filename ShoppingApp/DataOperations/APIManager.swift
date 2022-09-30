//
//  APIManager.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation
import Network

class APIManager: APIManagerProtocol {

    // MARK: - Singleton
    static let shared = APIManager()

    // MARK: - JSON Decoder
    private let jsonDecoder = JSONDecoder()

    // MARK: - Session
    private let session: URLSession

    init() {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 100
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        self.session = URLSession(configuration: config)
    }

    func executeRequest<R>(urlRequest: URLRequest, completion: @escaping (Result<R, Error>) -> Void) where R: Codable {
        session.dataTask(with: urlRequest) { [weak self] data, response, error in
            self?.dataTaskHandler(data, response, error, completion)
        }.resume()
    }

    private func dataTaskHandler<R>(_ data: Data?,
                                    _ response: URLResponse?,
                                    _ error: Error?,
                                    _ completion: @escaping (Result<R, Error>) -> Void) where R: Codable{
        if let error = error {
            debugPrint("dataTaskHandler error: \(String(describing: error))")
            completion(.failure(error))
        }

        if let data = data {
            do {
                debugPrint(String(data: data, encoding: .utf8) ?? "Undecoded data: \(data)")
                let dataDecoded = try jsonDecoder.decode(R.self, from: data)
                debugPrint("Decoded response data: \(dataDecoded)")
                completion(.success(dataDecoded))
            } catch {
                debugPrint("Decoding Error! \nCode: \(error._code) \nErrorDescription: \(error.localizedDescription)")
            }
        }
    }

    func cancelRequest() {
        session.invalidateAndCancel()
    }

    deinit {
        debugPrint("APIMANAGER DEINIT")
    }
}
