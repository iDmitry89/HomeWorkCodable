//
//  ModelsService.swift
//  HomeWorkCodable
//
//  Created by Dmitry on 25.06.2023.
//

import Foundation

struct ModelContainer: Codable {
    let dataModels1: [Model]
}

struct Model: Codable {
    let id: Int
    let make_id: Int
    let name: String
}

final class ModelsRequest: RequestModels {
    override var path: String {
        "/iDmitry89/HomeWorkCodable/db"
    }
}

final class ModelsService {
    private let apiClientModels = RestApiClient2()
    private let decoder = JSONDecoder()

    func fetchModels(completion: @escaping (Result<[Model], Error>) -> Void) {
        apiClientModels.makeRequestModels(ModelsRequest()) { result in
            switch result {
            case .success(let dataModels):
                do {
                    let modelContainer = try self.decoder.decode(ModelContainer.self, from: dataModels)
                    completion(.success(modelContainer.dataModels1))
                } catch {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
