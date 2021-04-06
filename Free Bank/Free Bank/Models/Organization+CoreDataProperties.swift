//
//  Organization+CoreDataProperties.swift
//  Free Bank
//
//  Created by Sasha Zontova on 3/5/21.
//
//

import CoreData
import Foundation

extension Organization {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Organization> {
        return NSFetchRequest<Organization>(entityName: "Organization")
    }

    @NSManaged public var codeWord: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var prn: String?
    @NSManaged public var accounts: NSSet?
    @NSManaged public var credits: NSSet?
    @NSManaged public var deposits: NSSet?
    @NSManaged public var staff: NSSet?

}

// MARK: Generated accessors for accounts
extension Organization {

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
extension Organization {

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
extension Organization {

    @objc(addDepositsObject:)
    @NSManaged public func addToDeposits(_ value: Deposit)

    @objc(removeDepositsObject:)
    @NSManaged public func removeFromDeposits(_ value: Deposit)

    @objc(addDeposits:)
    @NSManaged public func addToDeposits(_ values: NSSet)

    @objc(removeDeposits:)
    @NSManaged public func removeFromDeposits(_ values: NSSet)

}

// MARK: Generated accessors for staff
extension Organization {

    @objc(addStaffObject:)
    @NSManaged public func addToStaff(_ value: Individual)

    @objc(removeStaffObject:)
    @NSManaged public func removeFromStaff(_ value: Individual)

    @objc(addStaff:)
    @NSManaged public func addToStaff(_ values: NSSet)

    @objc(removeStaff:)
    @NSManaged public func removeFromStaff(_ values: NSSet)

}

extension Organization: Identifiable {}
