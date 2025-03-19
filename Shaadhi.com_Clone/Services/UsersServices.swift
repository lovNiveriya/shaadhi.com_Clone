//
//  GetUsersServices.swift
//  Shaadhi.com_Clone
//
//  Created by LOVE  on 19/03/25.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUsers() async throws -> [User]
}

final class UserServiceIMPL: UserServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let url: URL

    init(networkService: NetworkServiceProtocol = NetworkServiceIMPL(), url: URL) {
        self.networkService = networkService
        self.url = url
    }

    func fetchUsers() async throws -> [User] {
        let response: UserResponse = try await networkService.fetchData(from: url)
        return response.results
    }
}
