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

struct User: Codable {
    let id: ID
    let name: Name
    let location: Location
    let email: String
    let dob: DOB
    let picture: Picture
    let phone: String
    let cell: String
    var isSelected: Bool? = false

    struct ID: Codable, Hashable {
        let name: String?
        let value: String?
    }

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

extension User {
    static let mockUser = User(
        id: User.ID(name: "ssd", value: "djh-dkjs-dnn"), name: User.Name(title: "Mr", first: "John", last: "Doe"),
        location: User.Location(city: "New York", state: "NY", country: "USA"),
        email: "johndoe@example.com",
        dob: User.DOB(date: "1990-01-01", age: 34),
        picture: User.Picture(
            large: "https://randomuser.me/api/portraits/men/1.jpg",
            medium: "https://randomuser.me/api/portraits/med/men/1.jpg",
            thumbnail: "https://picsum.photos/340/600"
        ),
        phone: "(123) 456-7890",
        cell: "(987) 654-3210"
    )
}

