//
//  Transaction+CoreDataProperties.swift
//  Free Bank
//
//  Created by Sasha Zontova on 3/4/21.
//
//

import CoreData
import Foundation

extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: Int64
    @NSManaged public var date: Date?
    @NSManaged public var idNumber: Int64
    @NSManaged public var receiver: String?
    @NSManaged public var sender: String?
    @NSManaged public var accounts: NSSet?

}

// MARK: Generated accessors for accounts
extension Transaction {

    @objc(addAccountsObject:)
    @NSManaged public func addToAccounts(_ value: Account)

    @objc(removeAccountsObject:)
    @NSManaged public func removeFromAccounts(_ value: Account)

    @objc(addAccounts:)
    @NSManaged public func addToAccounts(_ values: NSSet)

    @objc(removeAccounts:)
    @NSManaged public func removeFromAccounts(_ values: NSSet)

}

extension Transaction : Identifiable {

}
