//
//  GetUsersServices.swift
//  Shaadhi.com_Clone
//
//  Created by LOVE  on 19/03/25.
//

import Foundation
import Combine

protocol UserServiceProtocol {
    func fetchUsers() -> AnyPublisher<[User], Error>
}

final class UserServiceIMPL: UserServiceProtocol {
    private let url = URL(string: "https://randomuser.me/api/?results=10")!

    func fetchUsers() -> AnyPublisher<[User], Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
