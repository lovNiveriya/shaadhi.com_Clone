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
}
