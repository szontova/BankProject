//
//  Branch+CoreDataProperties.swift
//  Free Bank
//
//  Created by Sasha Zontova on 2/23/21.
//
//

import Foundation
import CoreData


extension Branch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Branch> {
        return NSFetchRequest<Branch>(entityName: "Branch")
    }

    @NSManaged public var idNumber: Int64
    @NSManaged public var address: String?
    @NSManaged public var bank: Bank?

}

extension Branch : Identifiable {

}
