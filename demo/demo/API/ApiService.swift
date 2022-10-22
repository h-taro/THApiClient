//
//  ApiService.swift
//  demo
//
//  Created by 平石　太郎 on 2022/10/22.
//

import THApiClient

class ApiService {
    private lazy var apiClient: THApiClient = .init()
    
    func getUserResponses() async throws -> [UserResponse] {
        let request = GetUserRequest()
        return try await apiClient.call(request)
    }
}
