//
//  RestApiClient2.swift
//  HomeWorkCodable
//
//  Created by Dmitry on 25.06.2023.
//

import Foundation

final class RestApiClient2 {
    private let urlSessionModels: URLSession = .shared

    func makeRequestModels(_ request: RequestModels, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlRequest: URLRequest

        do {
            urlRequest = try request.buildRequestModels()
        } catch {
            completion(.failure(error))
            return
        }

        urlSessionModels.dataTask(with: urlRequest) { data, response, error in
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

