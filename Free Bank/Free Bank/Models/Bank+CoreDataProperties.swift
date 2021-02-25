//
//  Bank+CoreDataProperties.swift
//  Free Bank
//
//  Created by Пользователь on 23.02.21.
//
//

import Foundation
import CoreData


extension Bank {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bank> {
        return NSFetchRequest<Bank>(entityName: "Bank")
    }

    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var fullNumber: String?
    @NSManaged public var name: String?
    @NSManaged public var prn: String?
    @NSManaged public var shortNumber: String?
    @NSManaged public var account: Account?
    @NSManaged public var atms: NSSet?
    @NSManaged public var branches: NSSet?

}

// MARK: Generated accessors for atms
extension Bank {

    @objc(addAtmsObject:)
    @NSManaged public func addToAtms(_ value: ATM)

    @objc(removeAtmsObject:)
    @NSManaged public func removeFromAtms(_ value: ATM)

    @objc(addAtms:)
    @NSManaged public func addToAtms(_ values: NSSet)

    @objc(removeAtms:)
    @NSManaged public func removeFromAtms(_ values: NSSet)

}

// MARK: Generated accessors for branches
extension Bank {

    @objc(addBranchesObject:)
    @NSManaged public func addToBranches(_ value: Branch)

    @objc(removeBranchesObject:)
    @NSManaged public func removeFromBranches(_ value: Branch)

    @objc(addBranches:)
    @NSManaged public func addToBranches(_ values: NSSet)

    @objc(removeBranches:)
    @NSManaged public func removeFromBranches(_ values: NSSet)

}

extension Bank : Identifiable {

}
