//
//  RestAPIClient.swift
//  Garage
//
//  Created by Dmitry on 02.07.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case unacceptableCode
    case invalidClientRequest
    case serverFailed
    case undefined
}

final class RestApiClient {
    private let urlSession: URLSession = .shared

    func makeRequest(_ request: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlRequest: URLRequest

        do {
            urlRequest = try request.buildRequest()
        } catch {
            completion(.failure(error))
            return
        }

        urlSession.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, let response = response else {
                DispatchQueue.main.async {
                    completion(.failure(error ?? NetworkError.undefined))
                }
                return
            }

            if let error = self.validate(response: response) {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }

    private func validate(response: URLResponse) -> Error? {
        guard let httpReponse = response as? HTTPURLResponse else {
            return nil
        }

        switch httpReponse.statusCode {
        case 100..<200, 300..<400:
            return NetworkError.unacceptableCode
        case 400..<500:
            return NetworkError.invalidClientRequest
        case 500..<600:
            return NetworkError.serverFailed
        default:
            return nil
        }
    }
}
