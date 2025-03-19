//
//  UsersModel.swift
//  Shaadhi.com_Clone
//
//  Created by LOVE  on 19/03/25.
//

import Foundation

struct UserResponse: Codable {
    let results: [User]
}

struct User: Codable, Identifiable {
    let id = UUID()
    let name: Name
    let location: Location
    let email: String
    let dob: DOB
    let picture: Picture
    let phone: String
    let cell: String
    
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
    }

    struct Location: Codable {
        let city: String
        let state: String
        let country: String
    }

    struct DOB: Codable {
        let date: String
        let age: Int
    }

    struct Picture: Codable {
        let large: String
        let medium: String
        let thumbnail: String
    }
}
