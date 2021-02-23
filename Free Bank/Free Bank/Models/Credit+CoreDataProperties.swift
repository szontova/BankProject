//
//  Credit+CoreDataProperties.swift
//  Free Bank
//
//  Created by Sasha Zontova on 2/23/21.
//
//

import Foundation
import CoreData


extension Credit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Credit> {
        return NSFetchRequest<Credit>(entityName: "Credit")
    }

    @NSManaged public var idNumber: Int64
    @NSManaged public var amount: Int64
    @NSManaged public var procent: Int16
    @NSManaged public var term: Int64
    @NSManaged public var date: Date?
    @NSManaged public var indBorrower: Individual?
    @NSManaged public var account: Account?
    @NSManaged public var orgBorrower: Organization?

}

extension Credit : Identifiable {

}
