//
//  Food+CoreDataProperties.swift
//  iFood
//
//  Created by iosdev on 25.4.2017.
//  Copyright © 2017 Tien. All rights reserved.
//

import Foundation
import CoreData


extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food");
    }

    @NSManaged public var id: Int16
    @NSManaged public var info: String?
    @NSManaged public var kind: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var imageName: String?
    @NSManaged public var orderItem: NSSet?

}

// MARK: Generated accessors for orderItem
extension Food {

    @objc(addOrderItemObject:)
    @NSManaged public func addToOrderItem(_ value: Bill)

    @objc(removeOrderItemObject:)
    @NSManaged public func removeFromOrderItem(_ value: Bill)

    @objc(addOrderItem:)
    @NSManaged public func addToOrderItem(_ values: NSSet)

    @objc(removeOrderItem:)
    @NSManaged public func removeFromOrderItem(_ values: NSSet)

}
