//
//  Card+CoreDataProperties.swift
//  Free Bank
//
//  Created by Sasha Zontova on 4/6/21.
//
//

import Foundation
import CoreData

extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var cvv: Int16
    @NSManaged public var id: Int64
    @NSManaged public var validity: String?
    @NSManaged public var account: Account?

}

extension Card: Identifiable {}
