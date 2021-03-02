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
    
    //MARK:- FindEntities
    func findIndivididual(by login: String) -> Individual?{
        let individRequest = Individual.fetchRequest() as NSFetchRequest<Individual>
        individRequest.predicate = NSPredicate(format: "login == %@", login)
        do {
            let items = try context.fetch(individRequest)
            if items.count != 0 {
                return items[0]
            }
        } catch {
            print("Error in check login")
        }
        return nil
    }
    
    func findOrganization(by prn: String) -> Organization?{
        let orgRequest = Organization.fetchRequest() as NSFetchRequest<Organization>
        orgRequest.predicate = NSPredicate(format: "prn == %@", prn)
        do {
            let items = try context.fetch(orgRequest)
            if items.count != 0 {
            return items[0]
            }
        } catch {
            print("Error in check login")
        }
        return nil
    }
    
    //MARK:- ValidEntities
    func validIndividual(_ login: String, _ password: String) -> Bool{
        let individRequest = Individual.fetchRequest() as NSFetchRequest<Individual>
        let hashPassword = Insecure.MD5.hash(data: password.data(using: .utf8)!).compactMap{ String(format: "%02x", $0)}.joined()
        individRequest.predicate = NSPredicate(format: "login == %@", login)
        do {
            let items = try context.fetch(individRequest)
            if items.count != 0 {
                if(items[0].password == hashPassword){
                    return true
                }
            }
        } catch {
            print("Error in check login")
        }
        return false
    }
    
    func validOrganization(_ prn: String, _ password: String) -> Bool{
        let individRequest = Organization.fetchRequest() as NSFetchRequest<Organization>
        let hashPassword = Insecure.MD5.hash(data: password.data(using: .utf8)!).compactMap{ String(format: "%02x", $0)}.joined()
        individRequest.predicate = NSPredicate(format: "prn == %@", prn)
        do {
            let items = try context.fetch(individRequest)
            if items.count != 0 {
                if(items[0].password == hashPassword){
                    return true
                }
            }
        } catch {
            print("Error in check login")
        }
        return false
    }
    
    //MARK:- AddEntities
    func addIndividal (_ name: String, _ email: String, _ login: String, _ password: String, _ codeWord: String) {
        
        let newIndivid = Individual(context: context)
        let newAccount = Account(context: context)
        
        newIndivid.fullName = name
        newIndivid.email = email
        newIndivid.login = login
        newIndivid.password = Insecure.MD5.hash(data: password.data(using: .utf8)!).compactMap{ String(format: "%02x", $0)}.joined()
        newIndivid.codeWord = codeWord.lowercased()
       
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
        newOrganization.password = Insecure.MD5.hash(data: password.data(using: .utf8)!).compactMap{ String(format: "%02x", $0)}.joined()
        newOrganization.codeWord = codeWord.lowercased()
        
        newAccount.idNumber = generationIdAccount("S")
        newOrganization.addToAccounts(newAccount)
        
        do {
            context.insert(newOrganization)
            context.insert(newAccount)
            try context.save()
        }
        catch { print("addOrganization: error in add organization") }
    }
    
    func addBranch(address: String){
        let newBranch = Branch(context: context)
        newBranch.idNumber = generationIdBranch()
        newBranch.address = address
        
        do {
            context.insert(newBranch)
            try context.save()
        } catch {
            print("addBranch: error in add address")
        }
    }
    
    func addATM(address: String){
        let newATM = ATM(context: context)
        newATM.idNumber = generationIdATM()
        newATM.address = address
        
        do {
            context.insert(newATM)
            try context.save()
        } catch {
            print("addATM: error in add address")
        }
    }

    
    //MARK: -HelperFunctions
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
    
    func generationIdBranch () -> Int64{
        var id: Int64 = 0
        let request = Branch.fetchRequest() as NSFetchRequest<Branch>
        do{
            var items = try context.fetch(request)
            items.sort(by: {str1,str2 in return str1.idNumber < str2.idNumber})
            if (items.count == 0){
                id = 1
            }
            else{
                let newIdNumber = Int64(items.last!.idNumber) + 1
                id = newIdNumber
            }
        } catch{
            print("generation: error in add new branch")
        }
        return id
    }
    
    func generationIdATM () -> Int64{
        var id: Int64 = 0
        let request = ATM.fetchRequest() as NSFetchRequest<ATM>
        do{
            var items = try context.fetch(request)
            items.sort(by: {str1,str2 in return str1.idNumber < str2.idNumber})
            if (items.count == 0){
                id = 1
            }
            else{
                let newIdNumber = Int64(items.last!.idNumber) + 1
                id = newIdNumber
            }
        } catch{
            print("generation: error in add new atm")
        }
        return id
    }
    
    //MARK:- PrintEntities
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
    
    //MARK:- CrTemplateEntities
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

        if let _ = findIndivididual(by: tempLogins[0]) {
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
    
    func createBranches(){
        let tempAdresses = ["г. Минск, ул. Матусевича 20", "г. Минск, ул. Центральная 8", "г. Минск, ул. Подлесная 56", "г. Минск, ул. Ольшевского 18", "г. Минск, ул. Парковая 1", "г. Брест, ул. Рыжского 28", "г. Могилев, ул. Проспект Победы 1", "г. Могилев, ул. Дунина 20", "г. Витебск, ул. Пушкина 88а", "г. Витебск, Проспект Мунина 44", "г. Гомель, ул. Матусевича 88", "г. Гродно, ул. Центральная 22"]
        
        for i in 0..<tempAdresses.count{
            addBranch(address: tempAdresses[i])
        }
    }
    
    func createATMs(){
        let tempAdresses = ["г. Минск, ул. Матусевича 20", "г. Минск, ул. Минина 33", "г. Минск, ул. Академическая 2/1", "г. Минск, ул. Рижская 9", "г. Минск, ул. Ушакова 33", "г. Минск, ул. Ольшевского 18", "г. Минск, ул. Притыцкого 8", "г. Брест, ул. Бунина 44", "г. Брест, ул. Центральная 1", "г. Брест, ул. Рыжского 28", "г. Могилев, Проспект Победы 1", "г. Могилев, ул. ул. Дунина 20", "г. Витебск, ул. Центральная 21", "г. Витебск, ул. Пушкина 88а", "г. Витебск, Проспект Мунина 44", "г. Гомель, ул. Матусевича 88", "г. Гродно, ул. Центральная 22"]
        for i in 0..<tempAdresses.count{
            addATM(address: tempAdresses[i])
        }
    }
    
    func createTemplateOrganizations (){
        
        let tempNames = ["ЕАС Профессионал", "ГазПром"]
        let tempPRNs = ["139567099","333287012"]
        let tempEmails = ["prof@mail.ru", "gazprom@gmail.com"]
        let tempPassword = "Qwerty1234"
        let tempCodeWord = "CODEWORD"

        if let _ = findOrganization(by: tempPRNs[0]) {
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
    
    //MARK:- DeleteEntities
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

