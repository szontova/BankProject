//
//  CheckDataFunctions.swift
//  Free Bank
//
//  Created by Пользователь on 16.02.21.
//

import Foundation
import UIKit

extension UIViewController{
    
    func checkLogin(login: String) -> Bool{
        let allowLetters: Range<Character> = "A"..<"z"
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
        let allowNumbers: Range<Character> = "0"..<"9"
        //большая буква, маленькая буква, цифра
        var hasUpChar = false
        var hasLowChar = false
        var hasNumber = false
        
        for symb in password {
            if String(symb).lowercased() == String(symb) {
                hasLowChar = true
                if hasUpChar && hasLowChar && hasNumber { break }
            }
            if String(symb).uppercased() == String(symb) {
                hasUpChar = true
                if hasUpChar && hasLowChar && hasNumber { break }
            }
            if allowNumbers.contains(symb) {
                hasNumber = true
                if hasUpChar && hasLowChar && hasNumber { break }
            }
        }
        
        if (!hasNumber) || (!hasUpChar) || (!hasLowChar) {
            showAlertError(message: "Пароль должен содержать минимум одну цифру, одну строчную и одну прописную букву.")
            return false
        }
        
       return true
                
    }
    
    func checkUNP(unp: String) -> Int? {
              
        if unp.count != 9 {
            showAlertError( message: "Неверный формат УНП. Проверьте данные.")
            return nil
        }
        
        if let unpInt = Int(unp) {
            return unpInt
        }
        else {
            showAlertError( message: "УНП содержит посторонние символы. Проверьте данные.")
            return nil
        }
            
    }
    
    func checkPersonName (name: String) -> Bool {
        let allowLetters: Range<Character> = "А"..<"я"
        let words = name.components(separatedBy: [" "])
        if words.count != 3 {
            showAlertError(message: "ФИО должно состоять из трёх слов")
            return false
        }
        
        for word in words {
            if String(word.first!) == String(word.first!).lowercased() {
                showAlertError(message: "Неверный формат ФИО")
                return false
            }
            
            for symb in word {
                if  !allowLetters.contains(symb) {
                    showAlertError( message: "ФИО содержит посторонние символы")
                    return false
                }
            }
            
        }
        
        return true
    }
    
    func checkOrgName (name: String) -> Bool {
        let allowLetters: Range<Character> = "А"..<"я"
        let allowNumbers: Range<Character> = "0"..<"9"
        let allowSymbols: Set<Character> = [" ", "-"]
       
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
    
    
}
