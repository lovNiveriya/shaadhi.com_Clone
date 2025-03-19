//
//  NetworkService.swift
//  Shaadhi.com_Clone
//
//  Created by LOVE  on 19/03/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(from url: URL) async throws -> T
}

final class NetworkServiceIMPL: NetworkServiceProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
