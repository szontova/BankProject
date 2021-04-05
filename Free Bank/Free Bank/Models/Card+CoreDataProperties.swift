//
//  Card+CoreDataProperties.swift
//  Free Bank
//
//  Created by Пользователь on 23.02.21.
//
//

import CoreData
import Foundation

extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var cvv: Int16
    @NSManaged public var idNumber: Int64
    @NSManaged public var validity: String?
    @NSManaged public var account: Account?

}

extension Card : Identifiable {

}
