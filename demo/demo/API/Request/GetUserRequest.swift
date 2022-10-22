//
//  GetUserRequest.swift
//  demo
//
//  Created by 平石　太郎 on 2022/10/22.
//

import ApiClient

struct GetUserRequest: Requestable {
    var baseURL: String {
        "https://jsonplaceholder.typicode.com/"
    }
    
    var path: String {
        "users"
    }
    
    var method: HttpMethod {
        .get
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var parameters: [String : Any]? {
        nil
    }
}
