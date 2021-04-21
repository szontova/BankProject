//
//  Branch+CoreDataProperties.swift
//  Free Bank
//
//  Created by Sasha Zontova on 4/6/21.
//
//

import Foundation
import CoreData

extension Branch {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Branch> {
        return NSFetchRequest<Branch>(entityName: "Branch")
    }

    @NSManaged public var address: String?
    @NSManaged public var id: Int64
    @NSManaged public var bank: Bank?

}

extension Branch: Identifiable {}
