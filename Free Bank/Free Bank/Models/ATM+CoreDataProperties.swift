//
//  ATM+CoreDataProperties.swift
//  Free Bank
//
//  Created by Sasha Zontova on 2/23/21.
//
//

import Foundation
import CoreData


extension ATM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ATM> {
        return NSFetchRequest<ATM>(entityName: "ATM")
    }

    @NSManaged public var idNumber: Int64
    @NSManaged public var address: String?
    @NSManaged public var bank: Bank?

}

extension ATM : Identifiable {

}
