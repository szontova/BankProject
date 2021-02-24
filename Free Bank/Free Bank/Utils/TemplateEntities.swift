//
//  TemplateEntities.swift
//  Free Bank
//
//  Created by Пользователь on 24.02.21.
//

import Foundation
import UIKit
import CoreData

private let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

extension UIViewController {
    
    func createBank (){
        let bankRequest = Bank.fetchRequest() as NSFetchRequest<Bank>
        do {
            let banks = try context.fetch(bankRequest)
            if banks.isEmpty {
                let ourBank = Bank(context: context)
                let bankAccount = Account(context: context)
                
                bankAccount.idNumber = "BY00FREE000000FBA00000000000"
                bankAccount.balance = 100_000_000
                ourBank.account = bankAccount
                
                context.insert(ourBank)
                context.insert(bankAccount)
                try context.save()
            }
        } catch {
            print("createBank: Error in creating bank")
        }
    }
   
    func createTemplateIndividuals (){
        
    }
    
    func createTemplateOrganizations (){
        
    }
    
}

extension Bank {
    
    func string() -> String{
        
        let null = "Nothing"
        var result = "Name: "
        result += self.name ?? null
        result += "\nAccount: \n\t"
        result += self.account?.string() ?? null
        
        return result
        
    }
}

extension Account{
    
    func string() -> String{
        let null = "Nothing"
        var result =  "id: \(self.idNumber ?? null), balance: \(self.balance / 100)р."
        if let bank = self.bank {
            result += " bank: \(bank.name ?? null)"
        }
        return result
    }
    
}

