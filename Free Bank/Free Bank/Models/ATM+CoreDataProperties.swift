//
//  ATM+CoreDataProperties.swift
//  Free Bank
//
//  Created by Sasha Zontova on 4/6/21.
//
//

import Foundation
import CoreData

extension ATM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ATM> {
        return NSFetchRequest<ATM>(entityName: "ATM")
    }

    @NSManaged public var address: String?
    @NSManaged public var id: Int64
    @NSManaged public var bank: Bank?

}

extension ATM: Identifiable {}
