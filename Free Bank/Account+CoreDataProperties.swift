//
//  Account+CoreDataProperties.swift
//  Free Bank
//
//  Created by Sasha Zontova on 3/4/21.
//
//

import CoreData
import Foundation

extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var balance: Int64
    @NSManaged public var idNumber: String?
    @NSManaged public var bank: Bank?
    @NSManaged public var cards: NSSet?
    @NSManaged public var company: Organization?
    @NSManaged public var credit: Credit?
    @NSManaged public var owner: Individual?
    @NSManaged public var transactions: NSSet?
    @NSManaged public var deposit: Deposit?

}

// MARK: Generated accessors for cards
extension Account {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: Card)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: Card)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}

// MARK: Generated accessors for transactions
extension Account {
    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)
}
extension Account: Identifiable {}
