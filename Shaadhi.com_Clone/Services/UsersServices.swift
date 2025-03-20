//
//  GetUsersServices.swift
//  Shaadhi.com_Clone
//
//  Created by LOVE  on 19/03/25.
//

import Foundation
import CoreData

protocol UserServiceProtocol {
    func fetchUsers() async throws -> [User]
    func fetchUsersFromCoreData() -> [User]
}

final class UserServiceIMPL: UserServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let context = CoreDataManager.shared.context
    private let url: URL

    init(networkService: NetworkServiceProtocol = NetworkServiceIMPL(), url: URL) {
        self.networkService = networkService
        self.url = url
    }

    func fetchUsers() async throws -> [User] {
        do {
            let response: UserResponse = try await networkService.fetchData(from: url)
            let users = response.results

            saveUsersToCoreData(users)
            return users
        } catch {
            print("Fetching from API failed, loading from Core Data.")
            return fetchUsersFromCoreData()
        }
    }

    private func saveUsersToCoreData(_ users: [User]) {
        context.perform {
            self.clearUsersFromCoreData()

            for user in users {
                let entity = UserEntity(context: self.context)
                entity.id = user.id.value
                entity.firstName = user.name.first
                entity.lastName = user.name.last
                entity.email = user.email
                entity.city = user.location.city
                entity.country = user.location.country
                entity.age = Int16(user.dob.age)
                entity.imageUrl = user.picture.large
            }

            CoreDataManager.shared.saveContext()
        }
    }

    func fetchUsersFromCoreData() -> [User] {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            let storedUsers = try context.fetch(fetchRequest)
            return storedUsers.map { entity in
                User(
                    id: User.ID(name: "", value: entity.id ?? UUID().uuidString), name: User.Name(title: "", first: entity.firstName ?? "", last: entity.lastName ?? ""),
                    location: User.Location(city: entity.city ?? "", state: "", country: entity.country ?? ""),
                    email: entity.email ?? "",
                    dob: User.DOB(date: "", age: Int(entity.age)),
                    picture: User.Picture(large: entity.imageUrl ?? "", medium: "", thumbnail: ""),
                    phone: "",
                    cell: ""
                )
            }
        } catch {
            print("Failed to fetch users from Core Data: \(error.localizedDescription)")
            return []
        }
    }

    private func clearUsersFromCoreData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = UserEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to clear Core Data: \(error.localizedDescription)")
        }
    }
}
