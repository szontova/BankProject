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
            showAlertError( message: "Неверный формат логина Проверьте данные.")
            return false
        }
        
        for symb in login {
            if  (!allowLetters.contains(symb)) && (!allowSymbols.contains(symb)) {
                showAlertError( message: "Неверно введен логин. Проверьте данные.")
                return false
            }
        }
        
        return true
    }
    
    
    func checkUNP(unp: String) -> Int? {
              
        if unp.count != 9 {
            showAlertError( message: "УНП введён неверно. Проверьте данные.")
            return nil
        }
        
        if let unpInt = Int(unp) {
            return unpInt
        }
        else {
            showAlertError( message: "УНП введён неверно. Проверьте данные.")
            return nil
        }
            
    }
    
}
