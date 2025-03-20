//
//  UsersModel.swift
//  Shaadhi.com_Clone
//
//  Created by LOVE  on 19/03/25.
//

import Foundation

enum SelectionState: Int16, Codable {
    case none = 0
    case accepted = 1
    case rejected = 2
}

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
    var isSelected: Bool? = false
    var selectionState: SelectionState? = SelectionState.none

    struct ID: Codable, Hashable {
        let name: String?
        let value: String?
    }

    struct Name: Codable {
        let first: String
        let last: String
    }

    struct Location: Codable {
        let city: String
        let country: String
    }

    struct DOB: Codable {
        let age: Int
    }

    struct Picture: Codable {
        let large: String
    }
}

extension User {
    static let mockUser = User(
        id: User.ID(name: "ssd", value: "djh-dkjs-dnn"), name: User.Name(first: "John", last: "Doe"),
        location: User.Location(city: "New York", country: "USA"),
        email: "johndoe@example.com",
        dob: User.DOB(age: 34),
        picture: User.Picture(
            large: "https://randomuser.me/api/portraits/men/1.jpg"
        )
    )
}

