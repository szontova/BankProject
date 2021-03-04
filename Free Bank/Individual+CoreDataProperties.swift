//
//  Individual+CoreDataProperties.swift
//  Free Bank
//
//  Created by Sasha Zontova on 3/4/21.
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
    @NSManaged public var employer: Organization?
    @NSManaged public var deposit: NSSet?

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

// MARK: Generated accessors for deposit
extension Individual {

    @objc(addDepositObject:)
    @NSManaged public func addToDeposit(_ value: Deposit)

    @objc(removeDepositObject:)
    @NSManaged public func removeFromDeposit(_ value: Deposit)

    @objc(addDeposit:)
    @NSManaged public func addToDeposit(_ values: NSSet)

    @objc(removeDeposit:)
    @NSManaged public func removeFromDeposit(_ values: NSSet)

}

extension Individual : Identifiable {

}
