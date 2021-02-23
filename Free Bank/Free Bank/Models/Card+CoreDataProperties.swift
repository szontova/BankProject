//
//  Card+CoreDataProperties.swift
//  Free Bank
//
//  Created by Sasha Zontova on 2/23/21.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var idNumber: Int64
    @NSManaged public var cvv: Int16
    @NSManaged public var validity: String?
    @NSManaged public var account: Account?

}

extension Card : Identifiable {

}
