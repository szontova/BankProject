//
//  TemplateEntities.swift
//  Free Bank
//
//  Created by Пользователь on 24.02.21.
//

import CoreData
import CryptoKit
import UIKit

class CoreDataViewController: UIViewController {
    // MARK: - FindEntities
    // Individual
    func findIndivididual(by login: String) -> Individual? {
        let individRequest = Individual.fetchRequest() as NSFetchRequest<Individual>
        individRequest.predicate = NSPredicate(format: "login == %@", login)
        do {
            let items = try CoreDataConstants.context.fetch(individRequest)
            if items.count != 0 {
                return items[0]
            }
        } catch {
            print("Error in check login")
        }
        return nil
    }
    
    // Organization
    func findOrganization(by prn: String) -> Organization? {
        let orgRequest = Organization.fetchRequest() as NSFetchRequest<Organization>
        orgRequest.predicate = NSPredicate(format: "prn == %@", prn)
        do {
            let items = try CoreDataConstants.context.fetch(orgRequest)
            if items.count != 0 {
            return items[0]
            }
        } catch {
            print("Error in check login")
        }
        return nil
    }
    
    // Account
    func findAccount(by id: String) -> Account? {
        let accountRequest = Account.fetchRequest() as NSFetchRequest<Account>
        accountRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let items = try CoreDataConstants.context.fetch(accountRequest)
            if items.count != 0 {
                return items[0]
            }
        } catch {
            print("Error in check accounts")
        }
        return nil
    }
    
    // Card
    func findCard(by id: String) -> Card? {
        let cardRequest = Card.fetchRequest() as NSFetchRequest<Card>
        cardRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let items = try CoreDataConstants.context.fetch(cardRequest)
            if items.count != 0 {
                return items[0]
            }
        } catch {
            print("Error in check accounts")
        }
        return nil
    }
    // MARK: - ValidEntities
    // Individual
    func validIndividual(_ login: String, _ password: String) -> Bool {
        let individRequest = Individual.fetchRequest() as NSFetchRequest<Individual>
        let hashPassword = Insecure.MD5.hash(data: password.data(using: .utf8)!).compactMap { String(format: "%02x", $0)}.joined()
        individRequest.predicate = NSPredicate(format: "login == %@", login)
        do {
            let items = try CoreDataConstants.context.fetch(individRequest)
            if items.count != 0 {
                if items[0].password == hashPassword {
                    return true
                }
            }
        } catch {
            print("Error in check login")
        }
        return false
    }
    // Organization
    func validOrganization(_ prn: String, _ password: String) -> Bool {
        let individRequest = Organization.fetchRequest() as NSFetchRequest<Organization>
        let hashPassword = Insecure.MD5.hash(data: password.data(using: .utf8)!).compactMap { String(format: "%02x", $0)}.joined()
        individRequest.predicate = NSPredicate(format: "prn == %@", prn)
        do {
            let items = try CoreDataConstants.context.fetch(individRequest)
            if items.count != 0 {
                if items[0].password == hashPassword {
                    return true
                }
            }
        } catch {
            print("Error in check login")
        }
        return false
    }
    // MARK: - AddEntities
    // Card
    func addCardForAccount( _ account: Account) {
        let newCard = Card(context: CoreDataConstants.context)
        var firsTemplateNumbers = 4725_6900_0000_0000
        switch MyCustomVC.getAccCategory(account) {
        case "S": firsTemplateNumbers += 19_0000_0000
        case "C": firsTemplateNumbers += 03_0000_0000
        case "D": firsTemplateNumbers += 04_0000_0000
        default: break
        }
        let numbersOfAccount = (Int(account.id!.suffix(7)) ?? 0) * 10
        let lastNumber = (account.cards?.count ?? 0) + 1
        let cardNumber = firsTemplateNumbers + numbersOfAccount + lastNumber
        newCard.id = Int64(cardNumber)
        newCard.validity = MyCustomVC.getValidityDate(4)
        newCard.cvv = Int16.random(in: 100..<1000)
        account.addToCards(newCard)
        do {
            CoreDataConstants.context.insert(newCard)
            try CoreDataConstants.context.save()
        } catch {
            print("addCard: error in saving context")
        }
    }
    // Account
    func addAccount (_ id: String, _ individ: Individual?, _ org: Organization?) {
        let newAccount = Account(context: CoreDataConstants.context)
        newAccount.id = id
        if individ != nil {
            individ?.addToAccounts(newAccount)
        }
        if org != nil {
            org?.addToAccounts(newAccount)
        }
        do {
            CoreDataConstants.context.insert(newAccount)
            try CoreDataConstants.context.save()
        } catch {
            print("addAccount: error in saving context")
        }
    }
    // Individual
    func addIndividal (_ name: String, _ email: String, _ login: String, _ password: String, _ codeWord: String) {
        let newIndivid = Individual(context: CoreDataConstants.context)
        let newAccount = Account(context: CoreDataConstants.context)
        newIndivid.fullName = name
        newIndivid.email = email
        newIndivid.login = login
        newIndivid.password = Insecure.MD5.hash(data: password.data(using: .utf8)!).compactMap { String(format: "%02x", $0)}.joined()
        newIndivid.codeWord = codeWord.lowercased()
        newAccount.id = generationIdAccount("S")
        newIndivid.addToAccounts(newAccount)
        do {
            CoreDataConstants.context.insert(newIndivid)
            CoreDataConstants.context.insert(newAccount)
            try CoreDataConstants.context.save()
        } catch {
            print("addIndividal: error in add individual")
        }
    }
    // Organization
    func addOrganization ( _ name: String, _ email: String, _ login: String, _ password: String, _ codeWord: String) {
        let newOrganization = Organization(context: CoreDataConstants.context)
        let newAccount = Account(context: CoreDataConstants.context)
        newOrganization.name = name
        newOrganization.email = email
        newOrganization.prn = login
        newOrganization.password = Insecure.MD5.hash(data: password.data(using: .utf8)!).compactMap { String(format: "%02x", $0)}.joined()
        newOrganization.codeWord = codeWord.lowercased()
        newAccount.id = generationIdAccount("S")
        newOrganization.addToAccounts(newAccount)
        do {
            CoreDataConstants.context.insert(newOrganization)
            CoreDataConstants.context.insert(newAccount)
            try CoreDataConstants.context.save()
        } catch { print("addOrganization: error in add organization") }
    }
    // Branch
    func addBranch(address: String) {
        let newBranch = Branch(context: CoreDataConstants.context)
        newBranch.id = generationIdBranch()
        newBranch.address = address
        do {
            CoreDataConstants.context.insert(newBranch)
            try CoreDataConstants.context.save()
        } catch {
            print("addBranch: error in add address")
        }
    }
    // ATM
    func addATM(address: String) {
        let newATM = ATM(context: CoreDataConstants.context)
        newATM.id = generationIdATM()
        newATM.address = address
        do {
            CoreDataConstants.context.insert(newATM)
            try CoreDataConstants.context.save()
        } catch {
            print("addATM: error in add address")
        }
    }
    // Credit
    func addCredit(_ amount: Int32, _ term: Int16, _ procent: Int16, _ date: Date, _ individ: Individual?, _ org: Organization?) {
        let newCredit = Credit(context: CoreDataConstants.context)
        let newAccount = Account(context: CoreDataConstants.context)
        let bankRequest = Bank.fetchRequest() as NSFetchRequest<Bank>
        var bankAccount: Account?
        do {
            let banks = try CoreDataConstants.context.fetch(bankRequest)
            for bank in banks {
                bankAccount = bank.account
            }
        } catch {
            print("createBank: error in get bank account")
        }
        newCredit.amount = amount
        newCredit.term = term
        newCredit.procent = procent
        newCredit.date = date
        newCredit.id = generationIdCredit(individ, org, term, amount)
        newAccount.id = generationIdAccount("C")
        newCredit.account = newAccount
        if individ != nil {
            individ?.addToCredits(newCredit)
            individ?.addToAccounts(newAccount)
        }
        if org != nil {
            org?.addToCredits(newCredit)
            org?.addToAccounts(newAccount)
        }
        do {
            CoreDataConstants.context.insert(newCredit)
            CoreDataConstants.context.insert(newAccount)
            try CoreDataConstants.context.save()
        } catch { print("addCredit: error in add credit") }
        _ = addTransaction(Int64(amount), (nil, bankAccount), (nil, newAccount))
    }
    // Deposit
    func addDeposit(_ amount: Int64, _ term: Int16, _ procent: Int16, _ date: Date, _ revocable: Bool, _ individ: Individual?, _ org: Organization?) {
        let newDeposit = Deposit(context: CoreDataConstants.context)
        let newAccount = Account(context: CoreDataConstants.context)
        newDeposit.amount = amount
        newDeposit.term = term
        newDeposit.procent = procent
        newDeposit.date = date
        newDeposit.revocable = revocable
        newDeposit.id = generationIdDeposit(individ, org, term, amount)
        newAccount.id = generationIdAccount("D")
        newAccount.balance = amount
        newDeposit.account = newAccount
        if individ != nil {
            individ?.addToDeposits(newDeposit)
            individ?.addToAccounts(newAccount)
        }
        if org != nil {
            org?.addToDeposits(newDeposit)
            org?.addToAccounts(newAccount)
        }
        do {
            CoreDataConstants.context.insert(newDeposit)
            CoreDataConstants.context.insert(newAccount)
            try CoreDataConstants.context.save()
        } catch { print("addDeposit: error in add deposit") }
        _ = addTransaction(Int64(amount), (nil, nil), (nil, newAccount))
    }
    // Transaction
    func addTransaction(_ amount: Int64, _ sender: (Card?, Account?), _ receiver: (Card?, Account?)) -> Bool {
        let newTransaction = Transaction(context: CoreDataConstants.context)
        let something = "Счёт вне банка"
        var allow = false
        newTransaction.id = generationIdTransaction(amount, sender, receiver)
        newTransaction.amount = amount
        newTransaction.date = MyCustomVC.getDate()
        if let cardSender = sender.0 {
            if BaseVCConstants.base.checkAccountBalance(amount, (sender.0?.account!.balance)!) {
                cardSender.account?.balance = cardSender.account!.balance - amount
                cardSender.account?.addToTransactions(newTransaction)
                newTransaction.sender = String(cardSender.id)
                allow = true
            } else {
                showAlertMessage("Недостаточно средств.", "Уведомление")
            }
        } else if let accountSender = sender.1 {
            if BaseVCConstants.base.checkAccountBalance(amount, (sender.1?.balance)!) {
                accountSender.balance -= amount
                accountSender.addToTransactions(newTransaction)
                newTransaction.sender = accountSender.id
                allow = true
            } else {
                showAlertMessage("Недостаточно средств.", "Уведомление")
            }
        } else {
            newTransaction.sender = something
        }
        if let cardReceiver = receiver.0 {
            if let accountReciever = findAccount(by: cardReceiver.account?.id ?? "") {
                if allow {
                    accountReciever.balance += amount
                }
                accountReciever.addToTransactions(newTransaction)
                newTransaction.receiver = String(cardReceiver.id)
            }
        } else if let accountReceiver = receiver.1 {
            if let ourReciever = findAccount(by: accountReceiver.id ?? "") {
                if allow {
                    ourReciever.balance += amount
                }
                ourReciever.addToTransactions(newTransaction)
                newTransaction.receiver = accountReceiver.id
            } else {
                newTransaction.receiver = something
            }
        } else {
            newTransaction.receiver = something
        }
        do {
            CoreDataConstants.context.insert(newTransaction)
            try CoreDataConstants.context.save()
        } catch { print("addTransaction: error in add transaction") }
        return allow
    }
    // MARK: - GenerationID
    // Account
    func generationIdAccount (_ category: String) -> String {
        var result: String = ""
        let request = Account.fetchRequest() as NSFetchRequest<Account>
        let predicate = NSPredicate(format: "id LIKE %@", "????????????????" + category + "???????????")
        request.predicate = predicate
        do {
            var items = try CoreDataConstants.context.fetch(request)
            items.sort(by: {str1, str2 in return str1.id! < str2.id!})
            if items.count == 0 {
                result = "BY00FREE000000FB" + category + "00000000000"
                return result
            } else {
                let lastpart = (Int(items.last!.id?.suffix(11) ?? "0") ?? 0) + 1
                result = items.last!.id!.prefix(items.last!.id!.count - String(lastpart).count) + String(lastpart)
                return result
            }
        } catch {
            print("generationAccount: error in create accounts")
        }
        return result
    }
    // Branch
    func generationIdBranch () -> Int64 {
        var id: Int64 = 0
        let request = Branch.fetchRequest() as NSFetchRequest<Branch>
        do {
            var items = try CoreDataConstants.context.fetch(request)
            items.sort(by: {str1, str2 in return str1.id < str2.id})
            if items.count == 0 {
                id = 1
            } else {
                let newid = Int64(items.last!.id) + 1
                id = newid
            }
        } catch {
            print("generation: error in add new branch")
        }
        return id
    }
    // ATM
    func generationIdATM () -> Int64 {
        var id: Int64 = 0
        let request = ATM.fetchRequest() as NSFetchRequest<ATM>
        do {
            var items = try CoreDataConstants.context.fetch(request)
            items.sort(by: {str1, str2 in return str1.id < str2.id})
            if items.count == 0 {
                id = 1
            } else {
                let newid = Int64(items.last!.id) + 1
                id = newid
            }
        } catch {
            print("generation: error in add new atm")
        }
        return id
    }
    // Credit
    func generationIdCredit (_ ind: Individual?, _ org: Organization?, _ term: Int16, _ amount: Int32) -> Int64 {
        var id: Int64 = 1_0000_0000
        let creditRequest = Credit.fetchRequest() as NSFetchRequest<Credit>
        do {
            var items = try CoreDataConstants.context.fetch(creditRequest)
            items.sort(by: {return $0.id < $1.id})
            if items.count == 0 { id *= 1 } else {
                let newid = Int64(items.last!.id / id) + 1
                id *= newid
            }
        } catch {
            print("generation: error in add new credit")
        }
        if ind != nil {
            id += (Int64)(ind?.credits?.count ?? 0) % 10 * 1000_0000
        }
        if org != nil {
            id += (Int64)(org?.credits?.count ?? 0) % 10 * 1000_0000
        }
        id += Int64(term) * 100000
        id += Int64(amount) / 100
        return id
    }
    // Deposit
    func generationIdDeposit (_ ind: Individual?, _ org: Organization?, _ term: Int16, _ amount: Int64) -> Int64 {
        var id: Int64 = 1_0000_0000
        let depositRequest = Deposit.fetchRequest() as NSFetchRequest<Deposit>
        do {
            var items = try CoreDataConstants.context.fetch(depositRequest)
            items.sort(by: {return $0.id < $1.id})
            if items.count == 0 { id *= 1 } else {
                let newid = Int64(items.last!.id / id) + 1
                id *= newid
            }
        } catch {
            print("generation: error in add new deposit")
        }
        if ind != nil {
            id += (Int64)(ind?.deposits?.count ?? 0) % 10 * 1000_0000
        }
        if org != nil {
            id += (Int64)(org?.deposits?.count ?? 0) % 10 * 1000_0000
        }
        id += Int64(term) * 100000
        id += Int64(amount) / 100
        return id
    }
    // Transaction
    func generationIdTransaction (_ amount: Int64, _ sender: (Card?, Account?), _ receiver: (Card?, Account?)) -> Int64 {
        var id: Int64 = 1_00000
        let transactionRequest = Transaction.fetchRequest() as NSFetchRequest<Transaction>
        do {
            var items = try CoreDataConstants.context.fetch(transactionRequest)
            items.sort(by: {return $0.id < $1.id})
            if items.count == 0 { id *= 1 } else {
                let newid = Int64(items.last!.id / id) + 1
                id *= newid
            }
        } catch {
            print("generation: error in add new transaction")
        }
        var category: Int64 = 0
        if sender.0 != nil && receiver.0 != nil { category = 1 }
        if sender.0 != nil && receiver.1 != nil { category = 2 }
        if sender.1 != nil && receiver.0 != nil { category = 3 }
        if sender.1 != nil && receiver.1 != nil { category = 4 }
        id += category % 10 * 10000
        id += Int64(amount) / 100
        return id
    }
    // MARK: - PrintAllEntities

    // Individual
    func printAllIndividual() {
        let request = Individual.fetchRequest() as NSFetchRequest<Individual>
        do {
            let items = try CoreDataConstants.context.fetch(request)
            for item in 0..<items.count {
                print(items[item].string())
            }
        } catch { print("printAllIndividual: error in print people") }
    }
    // Account
    func printAllAccounts() {
        let request = Account.fetchRequest() as NSFetchRequest<Account>
        do {
            let items = try CoreDataConstants.context.fetch(request)
            for item in 0..<items.count {
                print(items[item].string())
            }
        } catch { print("printAllAccounts: error in print accounts") }
    }
    // Organization
    func printAllOrganization() {
        let request = Organization.fetchRequest() as NSFetchRequest<Organization>
        do {
            let items = try CoreDataConstants.context.fetch(request)
            for item in 0..<items.count {
                print(items[item].string())
            }
        } catch { print("printAllOrganization: error in print people") }
    }
    // MARK: - CreateTemplateEntities

    // Bank
    func createBank () {
        let bankRequest = Bank.fetchRequest() as NSFetchRequest<Bank>
        do {
            let banks = try CoreDataConstants.context.fetch(bankRequest)
            if banks.isEmpty {
                let ourBank = Bank(context: CoreDataConstants.context)
                let bankAccount = Account(context: CoreDataConstants.context)
                bankAccount.id = "BY00FREE000000FBA00000000000"
                bankAccount.balance = 100_000_000
                ourBank.account = bankAccount
                CoreDataConstants.context.insert(ourBank)
                CoreDataConstants.context.insert(bankAccount)
                try CoreDataConstants.context.save()
            } else {
               // print("createBank: bank is here")
            }
        } catch {
            print("createBank: error in creating bank")
        }
    }
    // Individuals
    func createTemplateIndividuals () {
        let tempNames = ["Чубакова Валерия Вадимовна", "Зонтова Александра Юрьевна", "Чекун Илья Леонидович"]
        let tempLogins = ["lerachubakova", "shzontova", "ilchekun"]
        let tempEmails = ["valeri_1605@mail.ru", "shzontova@gmail.com", "ilchekun@bsuir.by"]
        let tempPassword = "Qwerty1234"
        let tempCodeWord = "CODEWORD"

        if findIndivididual(by: tempLogins[0]) != nil {
//            print("createTemplateIndividuals: template people are here")
//            for i in 0..<tempLogins.count {
//                deleteIndividual(by: tempLogins[i])
//            }
        } else {
            for item in 0..<tempLogins.count {
            addIndividal(tempNames[item], tempEmails[item], tempLogins[item], tempPassword, tempCodeWord)
            }
        }

    }
    // Branches
    func createBranches() {
        let tempAdresses = ["г. Минск, ул. Матусевича 20", "г. Минск, ул. Центральная 8", "г. Минск, ул. Подлесная 56", "г. Минск, ул. Ольшевского 18", "г. Минск, ул. Парковая 1", "г. Брест, ул. Рыжского 28", "г. Могилев, ул. Проспект Победы 1"]
        for item in 0..<tempAdresses.count {
            addBranch(address: tempAdresses[item])
        }
    }
    // ATMs
    func createATMs() {
        let tempAdresses = ["г. Минск, ул. Матусевича 20", "г. Минск, ул. Минина 33", "г. Минск, ул. Академическая 2/1", "г. Минск, ул. Рижская 9", "г. Минск, ул. Ушакова 33", "г. Минск, ул. Ольшевского 18", "г. Минск, ул. Притыцкого 8", "г. Брест, ул. Бунина 44", "г. Брест, ул. Центральная 1"]
        for item in 0..<tempAdresses.count {
            addATM(address: tempAdresses[item])
        }
    }
    // Organizations
    func createTemplateOrganizations () {
        let tempNames = ["ЕАС Профессионал", "ГазПром"]
        let tempPRNs = ["139567099", "333287012"]
        let tempEmails = ["prof@mail.ru", "gazprom@gmail.com"]
        let tempPassword = "Qwerty1234"
        let tempCodeWord = "CODEWORD"
        if findOrganization(by: tempPRNs[0]) != nil {
//            print("createTemplateOrganizations: template organization are here")
//            for i in 0..<tempPRNs.count {
//                deleteOrganization(by: tempPRNs[i])
//            }
        } else {
            for item in 0..<tempPRNs.count {
            addOrganization(tempNames[item], tempEmails[item], tempPRNs[item], tempPassword, tempCodeWord)
            }
        }
    }
    // MARK: - DeleteEntities
    // Individual
    func deleteIndividual(by login: String) {
        let request = Individual.fetchRequest() as NSFetchRequest<Individual>
        request.predicate = NSPredicate(format: "login == %@", login)
        do {
            let items = try CoreDataConstants.context.fetch(request)
            if items.count == 0 {
                print("deleteIndividual: nobody deleted")
                return
            }
            for item in 0..<items.count {
                CoreDataConstants.context.delete(items[item])
                try CoreDataConstants.context.save()
            }
            print("deleteIndividual: \(login) deleted")
        } catch {
            print("deleteIndividual: Error in deleting")
        }
    }

    // Organization
    func deleteOrganization(by prn: String) {
        let request = Organization.fetchRequest() as NSFetchRequest<Organization>
        request.predicate = NSPredicate(format: "prn == %@", prn)
        do {
            let items = try CoreDataConstants.context.fetch(request)
            if items.count == 0 {
                print("deleteOrganization: nobody deleted")
                return
            }
            for item in 0..<items.count {
                CoreDataConstants.context.delete(items[item])
                try CoreDataConstants.context.save()
            }
            print("deleteOrganization: \(prn) deleted")
        } catch {
            print("deleteOrganization: Error in deleting")
        }
    }
    
    // Account
    func deleteAccount(by id: String) {
        let request = Account.fetchRequest() as NSFetchRequest<Account>
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            let items = try CoreDataConstants.context.fetch(request)
            if items.count == 0 {
                print("deleteAccount: nithing to delete")
                return
            }
            for item in 0..<items.count {
                CoreDataConstants.context.delete(items[item])
                try CoreDataConstants.context.save()
            }
            print("deleteAccount: \(id) deleted")
        } catch {
            print("deleteAccount: Error in deleting")
        }
    }
    func deleteAccount(_ acc: Account) {
        do {
            CoreDataConstants.context.delete(acc)
            try CoreDataConstants.context.save()
        } catch {
            print("deleteAccount: Error in deleting")
        }
    }
}

// MARK: - EntityExtensions

extension Bank {
    func string() -> String {
        let null = "Nothing"
        var result = "Name: "
        result += self.name ?? null
        result += "\nAccount: \n\t"
        result += self.account?.string() ?? null
        return result
    }
}

extension Individual {
    func string() -> String {
        let null = "Nothing"
        var result = "Login: "
        result += self.login ?? null
        result += "\nCodeWord: " + (self.codeWord ?? null)
        result += "\nAccounts: \n"
        if let accs = self.accounts?.allObjects {
            for acc in accs {
                if let str = acc as? Account {
                    result += "\t" + str.string() + "\n"
                }
            }
        }
        return result
    }
}

extension Organization {
    func string() -> String {
        let null = "Nothing"
        var result = "PRN: "
        result += self.prn ?? null
        result += "\nName: " + (self.name ?? null)
        result += "\nCodeWord: " + (self.codeWord ?? null)
        result += "\nAccounts: \n"
        if let accs = self.accounts?.allObjects {
            for acc in accs {
                if let str = acc as? Account {
                   result += "\t" + str.string() + "\n"
                }
            }
        }
        return result
    }
}

extension Account {
    func topUpAccountBalance (amount: Int64) {
        let newBalance = self.balance + amount
        if newBalance < 10000000 {
            self.balance = newBalance
            do { try CoreDataConstants.context.save() } catch { print("topUpAccountBalance: error save context") }
        } else {
            print("topUpAccountBalance: limit reached")
        }
    }
    func string() -> String {
        let null = "Nothing"
        var result =  "id: \(self.id ?? null), balance: \(self.balance / 100)р."
        if let bank = self.bank {
            result += " bank: \(bank.name ?? null)"
        }
        if let owner = self.owner {
            result += " owner: \(owner.login ?? null)"
        }
        if let company = self.company {
            result += " company: \(company.name ?? null)"
        }
        if let credit = self.credit {
            result += " credit: \(credit.id)"
        }
        result += "\nTransactions:\n"
        if let transactions = self.transactions?.allObjects {
            for transaction in transactions {
                if let trans = transaction as? Transaction {
                    result += "\t" + String(trans.id) + "\n"
                }
            }
        }
        return result
    }
}

extension Card {
    func string() -> String {
        let null = "Nothing"
        var result = "id: \(self.id),\n cvv: \(self.cvv),\n validity: \(self.validity ?? null)\n"
        if let account = self.account {
            result += " account: " + account.string()
        }
        return result
    }
}

extension Credit {
    func string() -> String {
        var result = "Credit:\n id: \(self.id)"
        result += "\n amount: \(self.amount)"
        result += "\n procent: \(self.procent)"
        result += "\n term: \(self.term)"
        result += "\n \(String(describing: self.date))"
                if let account = self.account {
            result += "\n Account: " + account.string()
        }
        if let ind = self.indBorrower {
            result += "\n indBorrower: " + ind.string()
        }
        if let org = self.orgBorrower {
            result += "\n orgBorrower: " + org.string()
        }
        return result
    }
}

extension Deposit {
    func string() -> String {
        var result = "Deposit:\n id: \(self.id)"
        result += "\n amount: \(self.amount)"
        result += "\n procent: \(self.procent)"
        result += "\n term: \(self.term)"
        result += "\n revocable: \(self.revocable)"
        result += "\n \(String(describing: self.date))"
        if let account = self.account {
            result += "\n Account: " + account.string()
        }
        if let ind = self.indOwner {
            result += "\n indOwner: " + ind.string()
        }
        if let org = self.orgOwner {
            result += "\n indOwner: " + org.string()
        }
        return result
    }
}

extension Transaction {
    func string() -> String {
        var result = "Transaction:\n id: \(self.id)"
        result += "\n amount: \(self.amount)"
        result += "\n sender: \(self.sender ?? "")"
        result += "\n receiver: \(self.receiver ?? "")"
        result += "\n \(String(describing: self.date))"
        result += "\nAccounts:\n"
        if let accounts = self.accounts?.allObjects {
            for account in accounts {
                if let acc = account as? Account {
                   result += "\t" + acc.string() + "\n"
                }
            }
        }
        return result
    }
}
