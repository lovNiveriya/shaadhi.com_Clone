//
//  UserEntity+CoreDataProperties.swift
//  Shaadhi.com_Clone
//
//  Created by LOVE  on 20/03/25.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var email: String?
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var id: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var age: Int16

}

extension UserEntity : Identifiable {

}
