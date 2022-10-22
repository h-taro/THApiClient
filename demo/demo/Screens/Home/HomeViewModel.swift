//
//  HomeViewModel.swift
//  demo
//
//  Created by 平石　太郎 on 2022/10/22.
//

import THLogger
import Combine

class HomeViewModel: ObservableObject {
    @Published var users: [UserResponse] = []
    
    private lazy var apiService: ApiService = .init()

    func onAppear() {
        updateUsers()
    }
    
    // MARK: - PRIVATE METHODS
    private func updateUsers() {
        Task {
            do {
                let users = try await apiService.getUserResponses()
                
                Task { @MainActor in
                    self.users = users
                }
            } catch {
                THLogger.debug(error)
            }
        }
    }
}
