//
//  Branch+CoreDataProperties.swift
//  Free Bank
//
//  Created by Пользователь on 23.02.21.
//
//

import CoreData
import Foundation

extension Branch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Branch> {
        return NSFetchRequest<Branch>(entityName: "Branch")
    }

    @NSManaged public var address: String?
    @NSManaged public var idNumber: Int64
    @NSManaged public var bank: Bank?

}

extension Branch : Identifiable {

}
