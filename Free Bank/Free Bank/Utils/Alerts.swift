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
    
    func showAlertForgotPassword(message: String, login: String?){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            
        let attributedString = NSAttributedString(string: "Восстановление пароля", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ])
        alert.setValue(attributedString, forKey: "attributedTitle")
                
        alert.view.tintColor = UIColor.black
        
        alert.addTextField(configurationHandler: {
            (textField) in
            textField.placeholder = "Введите логин"
            textField.text = login ?? ""
            textField.borderStyle = UITextField.BorderStyle.roundedRect
        })
        
        alert.addTextField(configurationHandler: {
            (textField) in
            textField.placeholder = "Введите email"
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
                
        let okAction = UIAlertAction(title: "OK", style: .default){_ in}
        alert.addAction(okAction)
                
        present(alert, animated: true, completion: nil)
    }
}

