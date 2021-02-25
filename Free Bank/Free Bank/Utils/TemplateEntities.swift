//
//  TemplateEntities.swift
//  Free Bank
//
//  Created by Пользователь on 24.02.21.
//

import Foundation
import UIKit
import CoreData
import CryptoKit

private let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

extension UIViewController {
    
    //MARK:- Add entities
    func addIndividal (_ name: String, _ email: String, _ login: String, _ password: String, _ codeWord: String) {
        
        let newIndivid = Individual(context: context)
        let newAccount = Account(context: context)
        
        newIndivid.fullName = name
        newIndivid.email = email
        newIndivid.login = login
        newIndivid.password = Insecure.MD5.hash(data: password.data(using: .utf8)!).compactMap{ String(format: "%02x", $0)}.joined()
        newIndivid.codeWord = codeWord
       
        newAccount.idNumber = generationIdAccount("S")
        newIndivid.addToAccounts(newAccount)
    
        do {
            context.insert(newIndivid)
            context.insert(newAccount)
            try context.save()
        } catch {
            print("addIndividal: error in add individual")
        }
        
    }
    
    func addOrganization ( _ name: String, _ email: String, _ login: String, _ password: String, _ codeWord: String) {
        
        let newOrganization = Organization(context: context)
        let newAccount = Account(context: context)
        
        newOrganization.name = name
        newOrganization.email = email
        newOrganization.prn = login
        newOrganization.password = password
        newOrganization.codeWord = codeWord
        
        newAccount.idNumber = generationIdAccount("S")
        newOrganization.addToAccounts(newAccount)
        
        do {
            context.insert(newOrganization)
            context.insert(newAccount)
            try context.save()
        }
        catch { print("addOrganization: error in add organization") }
    }
    
    func generationIdAccount (_ category: String) -> String {
        var result: String = ""
        
        let request = Account.fetchRequest() as NSFetchRequest<Account>
        let predicate = NSPredicate(format: "idNumber LIKE %@",  "????????????????" + category + "???????????")
        request.predicate = predicate
        do{
            
            var items = try context.fetch(request)
            items.sort(by: {str1,str2 in return str1.idNumber! < str2.idNumber!})
            if (items.count == 0){
                result = "BY00FREE000000FB" + category + "00000000000"
                return result
            }
            else{
                let lastpart = (Int(items.last!.idNumber?.suffix(11) ?? "0") ?? 0) + 1
                result = items.last!.idNumber!.prefix(items.last!.idNumber!.count - String(lastpart).count) + String(lastpart)
                return result
            }
        } catch{
            print("generationAccount: error in create accounts")
        }
        
        return result
    }
    //MARK:- Print entities
    func printAllIndividual(){
        let request = Individual.fetchRequest() as NSFetchRequest<Individual>
        do {
            let items = try context.fetch(request)
            for i in 0..<items.count {
                print(items[i].string())
            }
            
        }
        catch { print("printAllIndividual: error in print people") }
    }
    
    func printAllAccounts(){
        let request = Account.fetchRequest() as NSFetchRequest<Account>
        do {
            let items = try context.fetch(request)
            for i in 0..<items.count {
                print(items[i].string())
            }
            
        }
        catch { print("printAllAccounts: error in print accounts") }
    }
    
    func printAllOrganization(){
        let request = Organization.fetchRequest() as NSFetchRequest<Organization>
        do {
            let items = try context.fetch(request)
            for i in 0..<items.count {
                print(items[i].string())
            }
            
        }
        catch { print("printAllOrganization: error in print people") }
    }
    
    //MARK:- Create entities
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
            } else {
               // print("createBank: bank is here")
            }
        } catch {
            print("createBank: error in creating bank")
        }
    }
   
    func createTemplateIndividuals (){
 
        let tempNames = ["Чубакова Валерия Вадимовна", "Зонтова Александра Юрьевна", "Чекун Илья Леонидович"]
        let tempLogins = ["lerachubakova","shzontova","ilchekun"]
        let tempEmails = ["valeri_1605@mail.ru", "shzontova@gmail.com", "ilchekun@bsuir.by"]
        let tempPassword = "Qwerty1234"
        let tempCodeWord = "CODEWORD"

        if findIndivididual(by: tempLogins[0]) {
//            print("createTemplateIndividuals: template people are here")
//            for i in 0..<tempLogins.count {
//                deleteIndividual(by: tempLogins[i])
//            }
        } else {
            for i in 0..<tempLogins.count {
            addIndividal(tempNames[i], tempEmails[i], tempLogins[i], tempPassword, tempCodeWord)
            }
        }

    }
    
    func createTemplateOrganizations (){
        
        let tempNames = ["ЕАС Профессионал", "ГазПром"]
        let tempPRNs = ["139567099","333287012"]
        let tempEmails = ["prof@mail.ru", "gazprom@gmail.com"]
        let tempPassword = "Qwerty1234"
        let tempCodeWord = "CODEWORD"

        if findOrganization(by: tempPRNs[0]) {
//            print("createTemplateOrganizations: template organization are here")
//            for i in 0..<tempPRNs.count {
//                deleteOrganization(by: tempPRNs[i])
//            }
        } else {
            for i in 0..<tempPRNs.count {
            addOrganization(tempNames[i], tempEmails[i], tempPRNs[i], tempPassword, tempCodeWord)
            }
        }
                
    }
    
    //MARK:- Delete entities
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
            print("deleteIndividual: \(login) deleted")
        } catch {
            print("deleteIndividual: Error in deleting")
        }
    }

    func deleteOrganization(by prn: String){
        let request = Organization.fetchRequest() as NSFetchRequest<Organization>
        request.predicate = NSPredicate(format: "prn == %@", prn)
        do {
            let items = try context.fetch(request)
            if items.count == 0 {
                print("deleteOrganization: nobody deleted")
                return
            }
            
            for i in 0..<items.count {
                context.delete(items[i])
                try context.save()
            }
            print("deleteOrganization: \(prn) deleted")
        } catch {
            print("deleteOrganization: Error in deleting")
        }
    }

    func deleteAccount(by idNumber: String){
        let request = Account.fetchRequest() as NSFetchRequest<Account>
        request.predicate = NSPredicate(format: "idNumber == %@", idNumber)
        do {
            let items = try context.fetch(request)
            if items.count == 0 {
                print("deleteAccount: nithing to delete")
                return
            }
            
            for i in 0..<items.count {
                context.delete(items[i])
                try context.save()
            }
            print("deleteAccount: \(idNumber) deleted")
        } catch {
            print("deleteAccount: Error in deleting")
        }
    }
}

//MARK:- Entities extensions

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

extension Individual {
    
    func string() -> String{
        
        let null = "Nothing"
        var result = "Login: "
        result += self.login ?? null
        result += "\nPassword: " + (self.password ?? null)
        result += "\nCodeWord: " + (self.codeWord ?? null)
        result += "\nAccounts: \n\t"
        if let accs = self.accounts?.allObjects {
            for acc in accs {
                if let h = acc as? Account {
                   result += h.string()
                }
            }
        }
        return result
        
    }
}

extension Organization {
    
    func string() -> String{
        
        let null = "Nothing"
        var result = "PRN: "
        result += self.prn ?? null
        result += "\nName: " + (self.name ?? null)
        result += "\nPassword: " + (self.password ?? null)
        result += "\nCodeWord: " + (self.codeWord ?? null)
        result += "\nAccounts: \n\t"
        if let accs = self.accounts?.allObjects {
            for acc in accs {
                if let h = acc as? Account {
                   result += h.string()
                }
            }
        }
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
        if let owner = self.owner {
            result += " owner: \(owner.login ?? null)"
        }
        if let company = self.company {
            result += " company: \(company.name ?? null)"
        }
        return result
    }
    
}

