//
//  CheckDataFunctions.swift
//  Free Bank
//
//  Created by Пользователь on 16.02.21.
//

import Foundation
import UIKit

extension UIViewController{
    //MARK:- CheckOnePropery
    func checkLogin(login: String) -> Bool{
        let allowLetters: ClosedRange<Character> = "A"..."z"
        let allowSymbols: Set<Character> = [".","_"]
        
        if login.count < 8 || login.count > 30 {
            showAlertError( message: "Неверный формат логина. Проверьте данные.")
            return false
        }
        
        for symb in login {
            if  (!allowLetters.contains(symb)) && (!allowSymbols.contains(symb)) {
                showAlertError( message: "Логин содержит недопустимые символы. Проверьте данные.")
                return false
            }
        }
        
        return true
    }
    
    func checkPassword(password: String) -> Bool{
        
        if password.count < 8 || password.count > 50 {
            showAlertError( message: "Пароль должен быть не короче 8 и не длиннее 50 символов. Проверьте данные.")
            return false
        }
        
        let allowNumbers: ClosedRange<Character> = "0"..."9"
        //большая буква, маленькая буква, цифра
        var hasUpChar = false
        var hasLowChar = false
        var hasNumber = false
        
        for symb in password {
            if !hasLowChar{
                if String(symb).lowercased() == String(symb) {
                    hasLowChar = true
                    if hasUpChar && hasLowChar && hasNumber { break }
                }
            }
            if !hasUpChar{
                if String(symb).uppercased() == String(symb) {
                    hasUpChar = true
                    if hasUpChar && hasLowChar && hasNumber { break }
                }
            }
            if !hasNumber{
                if allowNumbers.contains(symb) {
                    hasNumber = true
                    if hasUpChar && hasLowChar && hasNumber { break }
                }
            }
        }
        
        if (!hasNumber) || (!hasUpChar) || (!hasLowChar) {
            showAlertError(message: "Пароль должен содержать минимум одну цифру, одну строчную и одну прописную букву.")
            return false
        }
        
       return true
                
    }
    
    func checkUNP(unp: String) -> Bool {
              
        if unp.count != 9 {
            showAlertError( message: "Неверный формат УНП. Проверьте данные.")
            return false
        }
        
        if let _ = Int(unp) {
           //
        } else {
            showAlertError( message: "УНП содержит посторонние символы. Проверьте данные.")
            return false
        }
        return true
    }
    
    
    func checkPersonName (name: String) -> Bool {
        let allowLetters: ClosedRange<Character> = "А"..."я"
        let allowSymbols: Set<Character> = ["ё"]
        let words = name.components(separatedBy: [" "])
        if words.count != 3 {
            showAlertError(message: "ФИО должно состоять из трёх слов")
            return false
        }
        
        for word in words {
          
            for symb in word {
                if  !allowLetters.contains(symb) && (!allowSymbols.contains(symb)) {
                    showAlertError( message: "ФИО содержит посторонние символы")
                    return false
                }
            }
            
        }
        
        return true
    }
    
    func checkOrgName (name: String) -> Bool {
        let allowLetters: ClosedRange<Character> = "А"..."я"
        let allowNumbers: ClosedRange<Character> = "0"..."9"
        let allowSymbols: Set<Character> = [" ", "-","ё"]
       
        if name.count > 50 {
            showAlertError( message: "Название компании превышает допустимую длину" )
            return false
        }
        
        for symb in name {
            if (!allowLetters.contains(symb)) && (!allowNumbers.contains(symb)) && (!allowSymbols.contains(symb)) {
                showAlertError( message: "Название компании содержит посторонние символы" )
                return false
            }
        }
        return true
    }
    
    func checkEmail (email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !emailPred.evaluate(with: email) {
            showAlertError(message: "Email ведён некорректно")
            return false
        }
        return true
    }
    
    //MARK:- CheckDatasInPages
    func checkSignInDatas(_ status: Int,  _ login: String, _ password: String) -> Bool{
             
        if login.isEmpty || password.isEmpty {
            showAlertError( message: "Введите логин и пароль.")
            return false
        }
        
        switch status{
        
        case 0:
            if !checkLogin(login: login) { return false }
            
        case 1:
            if !checkUNP(unp: login) { return false }
        
        default: break
        }
        
        return true
    }
    
    func checkSignUpDatas(_ status: Int, _ name: String, _ email: String, _ login: String, _ password: String, _ repeatPassword: String) -> Bool{
       
        if name.isEmpty || login.isEmpty || password.isEmpty || repeatPassword.isEmpty || email.isEmpty {
            showAlertError(message: "Не все поля заполнены.")
            return false
        }
        
        switch status{
        
        case 0:
            
            if !checkPersonName(name: name) { return false }
            
            if !checkLogin(login: login) { return false }
            
            if let _ = findIndivididual(by: login) {
                showAlertError( message: "Данный логин занят другим пользователем")
                return false
            }
            
        case 1:
            
            if !checkOrgName(name: name) { return false }
            
            if !checkUNP(unp: login) { return false }
            
            if let _ = findOrganization(by: login) {
                showAlertError( message: "Вы ввели уже существующий УНП")
                return false
            }
        default: break
        }
        if !checkEmail(email: email) { return false }
        
        if !checkPassword(password: password) { return false }
        
        if password != repeatPassword {
            showAlertError(message: "Пароли не совпадают")
            return false
        }
        
        return true
    }
    
    func checkCreditAmount(_ amount: Int) -> Bool{
        if amount < 100 || amount > 10000{
            showAlertError(message: "Неверно введена сумма кредита.")
            return false
        }
        return true
    }
    
    func checkCreditTerm(_ term: Int) -> Bool{
        if term < 6 || term > 84{
            showAlertError(message: "Неверно введен срок кредита.")
            return false
        }
        return true
    }
    
    func checkCreditSalary(_ amount: Int) -> Bool{
        if amount < 782 || amount > 2500{
            showAlertError(message: "Неверно введен минимальный доход.")
            return false
        }
        return true
    }
    
    func checkCreditDatas(_ amount: Int, _ term: Int, _ salary: Int) -> Bool{
        if amount == 0 || term == 0 || salary == 0 {
            showAlertError(message: "Не все поля заполнены.")
            return false
        }
        if !checkCreditAmount(amount) {return false}
        if !checkCreditTerm(term) {return false}
        if !checkCreditSalary(salary) {return false}
        
        return true
    }
    
}
