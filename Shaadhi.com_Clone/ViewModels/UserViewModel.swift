//
//  UserViewModel.swift
//  Shaadhi.com_Clone
//
//  Created by LOVE  on 19/03/25.
//

import Foundation
import Combine

final class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let userService: UserServiceProtocol

    init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    @MainActor
    func loadUsers() async {
        isLoading = true
        errorMessage = nil
        do {
            users = try await userService.fetchUsers()
        } catch {
            errorMessage = "Failed to fetch users: \(error.localizedDescription)"
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
