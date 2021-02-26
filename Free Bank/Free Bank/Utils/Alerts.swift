//
//  Alerts.swift
//  Free Bank
//
//  Created by Пользователь on 10.02.21.
//

import UIKit

extension UIViewController {
    
        func showAlertError(message: String){
        let alertError = UIAlertController(title: "", message: message, preferredStyle: .alert)
                
        let attributedString = NSAttributedString(string: "Ошибка", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor : UIColor.red
        ])
        alertError.setValue(attributedString, forKey: "attributedTitle")
            
        alertError.view.tintColor = UIColor.black
                
        let okAction = UIAlertAction(title: "OK", style: .default){_ in}
        alertError.addAction(okAction)
                
        present(alertError, animated: true, completion: nil)
    }
    
    func showAlertForgotPassword( _ status: Int, _  login: String){
        var statusString = ""
        
        switch status {
        case 0: statusString  = "логин"
        case 1: statusString = "УНП"
        default: break
        }
       
        let alert = UIAlertController(title: "", message: "Введите \(statusString) и email.", preferredStyle: .alert)
            
        let attributedString = NSAttributedString(string: "Восстановление пароля", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ])
        
        alert.setValue(attributedString, forKey: "attributedTitle")
                
        alert.view.tintColor = UIColor.black
        
        alert.addTextField(configurationHandler: {
            (textField) in
            textField.placeholder = "Введите \(statusString)"
            textField.text = login
            textField.borderStyle = UITextField.BorderStyle.roundedRect
        })
        
        alert.addTextField(configurationHandler: {
            (textField) in
            textField.placeholder = "Введите кодовое слово"
            textField.borderStyle = UITextField.BorderStyle.roundedRect
        })
        
        for textField in alert.textFields! {
            let container = textField.superview
            let effectView = container?.superview?.subviews[0]
            if (effectView != nil) {
                container?.backgroundColor = UIColor.clear
                effectView?.removeFromSuperview()
            }
        }
                
        let okAction = UIAlertAction(title: "Восстановить", style: .default){ _ in
            let login = alert.textFields![0].text ?? ""
            let email = alert.textFields![1].text ?? ""
          
                if status == 0 {
                    if !self.checkLogin(login: login) { return }
                    if !self.findIndivididual(by: login) {
                        self.showAlertError(message: "Пользователь не найден")
                    }
                    else{
                        
                    }
                } else if status == 1 {
                    if !self.findOrganization(by: login) {
                        self.showAlertError(message: "Организация не найдена")
                    } else {
                        
                    }
            }
            
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default){ _ in}
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
                
        present(alert, animated: true, completion: nil)
    }
    
}

