//
//  Request.swift
//  HomeWorkCodable
//
//  Created by Dmitry on 18.06.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class Request {
    var path: String { "" }
    var params: [String: Any] { [:] }
    var urlParams: [String: String] { [:] }
    var method: HTTPMethod { .get }

    private let host: String = "carapi.app"
    private let scheme: String = "https"

    final func buildRequest() throws -> URLRequest {
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

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if !params.isEmpty {
            request.httpBody = try JSONSerialization.data(withJSONObject: params)
        }

        return request
    }
}
