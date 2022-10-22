//
//  ApiService.swift
//  demo
//
//  Created by 平石　太郎 on 2022/10/22.
//

import ApiClient

class ApiService {
    private lazy var apiClient: ApiClient = .init()
    
    func getUserResponses() async throws -> [UserResponse] {
        let request = GetUserRequest()

    }
}
