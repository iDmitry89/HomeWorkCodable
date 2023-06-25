//
//  CarsService.swift
//  HomeWorkCodable
//
//  Created by Dmitry on 18.06.2023.
//

import Foundation

struct CarContainer: Codable {
    let data: [Car]
    //let total: Int
}

struct Car: Codable {
    let id: Int
    let name: String
}

final class CarsRequest: Request {
    override var path: String {
        "/api/makes"
    }
}

final class CarsService {
    private let apiClient = RestApiClient()
    private let decoder = JSONDecoder()

    func fetchCars(completion: @escaping (Result<[Car], Error>) -> Void) {
        apiClient.makeRequest(CarsRequest()) { result in
            switch result {
            case .success(let data):

                do {
                    let carContainer = try self.decoder.decode(CarContainer.self, from: data)
                    completion(.success(carContainer.data))
                } catch {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
