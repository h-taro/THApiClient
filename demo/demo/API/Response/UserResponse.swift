//
//  UserResponse.swift
//  demo
//
//  Created by 平石　太郎 on 2022/10/22.
//

struct UserResponse: Codable, Identifiable {
    let id: String
    let name: String
    let username: String
}
