//
//  RequestModels.swift
//  HomeWorkCodable
//
//  Created by Dmitry on 25.06.2023.
//

import Foundation

class RequestModels {
    var path: String { "" }
    var params: [String: Any] { [:] }
    var urlParams: [String: String] { [:] }
    var method: HTTPMethod { .get }

    private let host: String = "carapi.app"
    private let scheme: String = "https"

    final func buildRequestModels() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path

        if !urlParams.isEmpty {

            var queryItems = [URLQueryItem]()
            for key in urlParams.keys {
                let item = URLQueryItem(name: key, value: urlParams[key])
                queryItems.append(item)
            }
        }

        guard let url = components.url else {
            throw NetworkError.invalidUrl
        }

        var request2 = URLRequest(url: url)
        request2.httpMethod = method.rawValue

        if !params.isEmpty {
            request2.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        
        return request2
    }
}
