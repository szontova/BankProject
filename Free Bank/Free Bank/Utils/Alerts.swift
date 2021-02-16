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
    
}

