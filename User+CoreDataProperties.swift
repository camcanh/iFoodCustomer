//
//  User+CoreDataProperties.swift
//  iFood
//
//  Created by iosdev on 25.4.2017.
//  Copyright © 2017 Tien. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var id: Int16
    @NSManaged public var password: String?
    @NSManaged public var userName: String?
    @NSManaged public var bill: NSSet?

}

// MARK: Generated accessors for bill
extension User {

    @objc(addBillObject:)
    @NSManaged public func addToBill(_ value: Bill)

    @objc(removeBillObject:)
    @NSManaged public func removeFromBill(_ value: Bill)

    @objc(addBill:)
    @NSManaged public func addToBill(_ values: NSSet)

    @objc(removeBill:)
    @NSManaged public func removeFromBill(_ values: NSSet)

}
