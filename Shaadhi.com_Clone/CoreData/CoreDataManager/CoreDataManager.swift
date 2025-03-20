//
//  CoreDataManager.swift
//  Shaadhi.com_Clone
//
//  Created by LOVE  on 20/03/25.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "UserModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data store: \(error.localizedDescription)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save Core Data: \(error.localizedDescription)")
        }
    }

    func updateUserSelectionState(userId: String, newState: SelectionState) {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userId)
        do {
            let users = try context.fetch(fetchRequest)
            if let userEntity = users.first {
                userEntity.selectionState = newState
                CoreDataManager.shared.saveContext()
            }
        } catch {
            print("Failed to update selection state for userId \(userId): \(error.localizedDescription)")
        }
    }

}
