//
//  UserViewModel.swift
//  Shaadhi.com_Clone
//
//  Created by LOVE  on 19/03/25.
//

import Combine
import Foundation
import Network

final class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false

    private let userService: UserServiceProtocol
    private let networkMonitor: NetworkMonitor

    init(userService: UserServiceProtocol, networkMonitor: NetworkMonitor = NetworkMonitor.shared) {
        self.userService = userService
        self.networkMonitor = networkMonitor
    }

    @MainActor
    func loadUsers() async {
        isLoading = true
        errorMessage = nil
        do {
            if networkMonitor.isConnected {
                users = try await userService.fetchUsers()
            } else {
                users = userService.fetchUsersFromCoreData()
            }
        } catch {
            errorMessage = "Failed to fetch users: \(error.localizedDescription)"
            showAlert = true
        }
        isLoading = false
    }

    func acceptUser(_ user: User) {
        // Will Handle local persistence logic here
    }

    func declineUser(_ user: User) {
        // Will Handle local persistence logic here
    }
}
