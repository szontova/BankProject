//
//  Credit+CoreDataProperties.swift
//  Free Bank
//
//  Created by Sasha Zontova on 4/6/21.
//
//

import Foundation
import CoreData

extension Credit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Credit> {
        return NSFetchRequest<Credit>(entityName: "Credit")
    }

    @NSManaged public var amount: Int32
    @NSManaged public var date: Date?
    @NSManaged public var id: Int64
    @NSManaged public var procent: Int16
    @NSManaged public var term: Int16
    @NSManaged public var account: Account?
    @NSManaged public var indBorrower: Individual?
    @NSManaged public var orgBorrower: Organization?

}

extension Credit: Identifiable {}
