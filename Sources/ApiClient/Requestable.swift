//
//  File.swift
//  
//
//  Created by 平石　太郎 on 2022/10/19.
//

import Foundation

public protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension Requestable {
    public var urlRequest: URLRequest? {
        guard let url = url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        
        return request
    }

    private var url: URL? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        
        urlComponents.path += path
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }

    private var queryItems: [URLQueryItem]? {
        guard method == .get, let parameters = parameters else { return nil }
        
        return parameters.compactMap {
            return URLQueryItem(name: $0.key, value: String(describing: $0.value))
        }
    }

    private var body: Data? {
        guard [.post, .put, .patch].contains(method), let parameters = parameters else {
            return nil
        }
        return try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    }
}
