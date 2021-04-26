//
//  UIViewControllerExtension.swift
//  Free Bank
//
//  Created by Sasha Zontova on 4/5/21.
//

import UIKit

extension UIViewController {
    // MARK: AlertMesSegue
    func showAlertMessageWithSegue(message: String, segue: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let attributedString = NSAttributedString(string: "Уведомление", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        alert.setValue(attributedString, forKey: "attributedTitle")
        alert.view.tintColor = UIColor.black
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            self.performSegue(withIdentifier: segue, sender: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    // MARK: AlertMessage
    func showAlertMessage(_ message: String, _ title: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let attributedString = NSAttributedString(string: title, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        alert.setValue(attributedString, forKey: "attributedTitle")
        alert.view.tintColor = UIColor.black
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func transparentNavBar ( _ navigationBar: UINavigationBar ) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}
