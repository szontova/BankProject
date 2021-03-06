//
//  Deposit+CoreDataProperties.swift
//  Free Bank
//
//  Created by Sasha Zontova on 4/6/21.
//
//

import Foundation
import CoreData

extension Deposit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deposit> {
        return NSFetchRequest<Deposit>(entityName: "Deposit")
    }

    @NSManaged public var amount: Int64
    @NSManaged public var date: Date?
    @NSManaged public var id: Int64
    @NSManaged public var procent: Int16
    @NSManaged public var revocable: Bool
    @NSManaged public var term: Int16
    @NSManaged public var account: Account?
    @NSManaged public var indOwner: Individual?
    @NSManaged public var orgOwner: Organization?

}

extension Deposit: Identifiable {}
