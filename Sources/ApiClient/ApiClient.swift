//
//  ApiClient.swift
//  demo
//
//  Created by 平石　太郎 on 2022/10/18.
//

import Foundation

public class ApiClient {
    private let decoder: JSONDecoder
    private let waitTime: Int
    
    public init(decoder: JSONDecoder = .init(), waitTime: Int = 20) {
        self.decoder = decoder
        self.waitTime = waitTime
    }
    
    func call<T: Codable>(_ requestable: Requestable, session: URLSession = .shared) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            guard var urlRequest = requestable.urlRequest else {
                return continuation.resume(throwing: NetworkError.invalidRequest)
            }
            
            urlRequest.timeoutInterval = TimeInterval(waitTime)
            
            session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    return continuation.resume(throwing: error)
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    return continuation.resume(throwing: NetworkError.invalidResponse)
                }
                
                let statusCode: Int = response.statusCode
                
                switch statusCode {
                case 200...299:
                    do {
                        let body = try self.decoder.decode(T.self, from: data)
                        return continuation.resume(returning: body)
                    } catch {
                        return continuation.resume(throwing: NetworkError.parseError(error: error))
                    }
                    
                case 400...499:
                    guard let clientError = NetworkError.ClientError(rawValue: statusCode) else {
                        return continuation.resume(throwing: NetworkError.unknown(message: "\(statusCode)"))
                    }
                    
                    return continuation.resume(throwing: NetworkError.client(clientError, data: data))
                    
                case 500...599:
                    guard let serverError = NetworkError.ServerError(rawValue: statusCode) else {
                        return continuation.resume(throwing: NetworkError.unknown(message: "\(statusCode)"))
                    }
                    
                    return continuation.resume(throwing: NetworkError.server(serverError, data: data))
                    
                default:
                    return continuation.resume(throwing: NetworkError.unknown(message: "\(statusCode)"))
                }
            }
            .resume()
        }
    }
}
