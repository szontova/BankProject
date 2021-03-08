//
//  Individual+CoreDataProperties.swift
//  Free Bank
//
//  Created by Sasha Zontova on 3/5/21.
//
//

import Foundation
import CoreData


extension Individual {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Individual> {
        return NSFetchRequest<Individual>(entityName: "Individual")
    }

    @NSManaged public var codeWord: String?
    @NSManaged public var email: String?
    @NSManaged public var fullName: String?
    @NSManaged public var login: String?
    @NSManaged public var password: String?
    @NSManaged public var accounts: NSSet?
    @NSManaged public var credits: NSSet?
    @NSManaged public var deposits: NSSet?
    @NSManaged public var employer: Organization?

}

// MARK: Generated accessors for accounts
extension Individual {

    @objc(addAccountsObject:)
    @NSManaged public func addToAccounts(_ value: Account)

    @objc(removeAccountsObject:)
    @NSManaged public func removeFromAccounts(_ value: Account)

    @objc(addAccounts:)
    @NSManaged public func addToAccounts(_ values: NSSet)

    @objc(removeAccounts:)
    @NSManaged public func removeFromAccounts(_ values: NSSet)

}

// MARK: Generated accessors for credits
extension Individual {

    @objc(addCreditsObject:)
    @NSManaged public func addToCredits(_ value: Credit)

    @objc(removeCreditsObject:)
    @NSManaged public func removeFromCredits(_ value: Credit)

    @objc(addCredits:)
    @NSManaged public func addToCredits(_ values: NSSet)

    @objc(removeCredits:)
    @NSManaged public func removeFromCredits(_ values: NSSet)

}

// MARK: Generated accessors for deposits
extension Individual {

    @objc(addDepositsObject:)
    @NSManaged public func addToDeposits(_ value: Deposit)

    @objc(removeDepositsObject:)
    @NSManaged public func removeFromDeposits(_ value: Deposit)

    @objc(addDeposits:)
    @NSManaged public func addToDeposits(_ values: NSSet)

    @objc(removeDeposits:)
    @NSManaged public func removeFromDeposits(_ values: NSSet)

}

extension Individual : Identifiable {

}
