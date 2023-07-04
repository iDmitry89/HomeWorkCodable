//
//  CarService.swift
//  Garage
//
//  Created by Dmitry on 02.07.2023.
//

import Foundation

struct CarContainer: Codable {
    let data: [Marka]
}

struct Marka: Codable {
    let id: Int
    let name: String
    let model: Model
}

struct Model: Codable {
    let id: Int
    let model: String
}

final class CarRequest: Request {
    override var path: String {
        "/iDmitry89/HomeWorkCodable/db"
    }
}

final class CarsService {
    private let apiClient = RestApiClient()
    private let decoder = JSONDecoder()

    func fetchCars(completion: @escaping (Result<[Marka], Error>) -> Void) {
        apiClient.makeRequest(CarRequest()) { result in
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
