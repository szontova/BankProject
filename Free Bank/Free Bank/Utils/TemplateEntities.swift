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
    
    func addIndividal (_ name: String, _ email: String, _ login: String, _ password: String) {
        
        let newIndivid = Individual(context: context)
        
        newIndivid.fullName = name
        newIndivid.email = email
        newIndivid.login = login
        newIndivid.password = password
        
        //add account
        
        do {
            context.insert(newIndivid)
            try context.save()
        }
        catch { print("SignUpVC: Error in add individual") }
    }
    
    func addOrganization ( _ name: String, _ email: String, _ login: String, _ password: String) {
        
        let newOrganization = Organization(context: context)
        
        newOrganization.name = name
        newOrganization.email = email
        newOrganization.prn = login
        newOrganization.password = password
        
        //add account
        
        do {
            context.insert(newOrganization)
            try context.save()
        }
        catch { print("SignUpVC: Error in add organization") }
    }
    
    func generationAccount (_ category: String) -> String {
        var result: String = ""
        
        let request = Account.fetchRequest() as NSFetchRequest<Account>
        print("Im here")
        let predicate = NSPredicate(format: "idNumber LIKE %@",  "????????????????"+category+"???????????")
        request.predicate = predicate
        do{
            
            let items = try context.fetch(request)
            if (items.count == 0){
                result = "BY00FREE000000FB"+category+"00000000000"
                return result
            }
            else{
                let lastpart = (Int(items.last!.idNumber?.suffix(11) ?? "0") ?? 0) + 1
                result = items.last!.idNumber!.prefix(items.last!.idNumber!.count - String(lastpart).count) + String(lastpart)
                return result
            }
        } catch{
            print("SignUpVC: Error in create accounts")
        }
        
        return result
    }
    
    func printAllIndividual(){
        let request = Individual.fetchRequest() as NSFetchRequest<Individual>
        do {
            let items = try context.fetch(request)
            for i in 0..<items.count {
                print(items[i].login ?? "Nothing")
            }
            
        }
        catch { print("SignUpVC: Error in print people") }
    }
    
    func printAllOrganization(){
        let request = Organization.fetchRequest() as NSFetchRequest<Organization>
        do {
            let items = try context.fetch(request)
            for i in 0..<items.count {
                print(items[i].name ?? "Nothing")
            }
            
        }
        catch { print("SignUpVC: Error in print people") }
    }
    
    
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
 
        let tempNames = ["Чубакова Валерия Вадимовна", "Зонтова Александра Юрьевна", "Чекун Илья Леонидович"]
        let tempLogins = ["lerachubakova","shzontova","ilchekun"]
        let tempEmails = ["valeri_1605@mail.ru", "shzontova@gmail.com", "ilchekun@bsuir.by"]
        let tempPassword = "Qwerty1234"
        
        if findIndivididual(by: tempLogins[0]) {
            print("template people are here")
        } else {
            for i in 0..<tempLogins.count {
            addIndividal(tempNames[i], tempEmails[i], tempLogins[i], tempPassword)
            }
        }
                
    }
    
    func deleteIndividual(by login: String){
        let request = Individual.fetchRequest() as NSFetchRequest<Individual>
        request.predicate = NSPredicate(format: "login == %@", login)
        do {
            let items = try context.fetch(request)
            if items.count == 0 {
                print("deleteIndividual: nobody deleted")
                return
            }
            
            for i in 0..<items.count {
                context.delete(items[i])
                try context.save()
            }
        } catch {
            print("deleteIndividual: Error in deleting")
        }
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

