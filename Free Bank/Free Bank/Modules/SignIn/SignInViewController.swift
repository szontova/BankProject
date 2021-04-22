//
//  ViewController.swift
//  Free Bank
//
//  Created by Пользователь on 1.02.21.
//

import MBProgressHUD
import SkyFloatingLabelTextField
import UIKit

class SignInViewController: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet private weak var statusSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var loginTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var passwordTextField: SkyFloatingLabelTextField!
    private var login: String = ""
    // MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldsConfiguration()
    }
    // MARK: - OverrideMethods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toHomeSegue" else { return }
        guard let destinationTBC = segue.destination as? HomeTabBarController else { return }
        destinationTBC.setLogin(login)
        destinationTBC.setStatus(statusSegmentedControl.selectedSegmentIndex)
    }
    // MARK: - OurMethods
    func textFieldsConfiguration() {
        loginTextField.font = .systemFont(ofSize: 16.0)
        loginTextField.placeholderFont = .systemFont(ofSize: 16.0)
        loginTextField.titleFont = .boldSystemFont(ofSize: 14.0)
        
        passwordTextField.font = .systemFont(ofSize: 16.0)
        passwordTextField.placeholderFont = .systemFont(ofSize: 16.0)
        passwordTextField.titleFont = .boldSystemFont(ofSize: 14.0)
    }
    func showAlertForgotPassword(_ status: Int, _ login: String) {
        var statusString = ""
        switch status {
        case 0: statusString  = "логин"
        case 1: statusString = "УНП"
        default: break
        }
        let alert = UIAlertController(title: "", message: "Введите \(statusString) и кодовое слово.", preferredStyle: .alert)
        let attributedString = NSAttributedString(string: "Восстановление пароля", attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        alert.setValue(attributedString, forKey: "attributedTitle")
        alert.view.tintColor = UIColor.black
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Введите \(statusString)"
            textField.text = login
            textField.borderStyle = UITextField.BorderStyle.roundedRect
        })
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Введите кодовое слово"
            textField.borderStyle = UITextField.BorderStyle.roundedRect
        })
        for textField in alert.textFields! {
            let container = textField.superview
            let effectView = container?.superview?.subviews[0]
            if effectView != nil {
                container?.backgroundColor = UIColor.clear
                effectView?.removeFromSuperview()
            }
        }
        let okAction = UIAlertAction(title: "Восстановить", style: .default) {_ in
            let login = alert.textFields![0].text ?? ""
            let codeWord = alert.textFields![1].text ?? ""
            switch status {
            case 0:
                if !self.checkLogin(login: login) {return}
                if let person = self.findIndivididual(by: login) {
                    if person.codeWord == codeWord.lowercased() {
                        self.login = login
                        self.performSegue(withIdentifier: "toHomeSegue", sender: nil)
                    } else {
                        self.showAlertError(message: "Кодовое слово введено неверно")
                    }
                } else {
                    self.showAlertError(message: "Пользователь не найден")
                }
            case 1:
                if let org = self.findOrganization(by: login) {
                    if org.codeWord == codeWord.lowercased() {
                        self.login = login
                        self.performSegue(withIdentifier: "toHomeSegue", sender: nil)
                    } else {
                        self.showAlertError(message: "Кодовое слово введено неверно")
                    }
                } else {
                    self.showAlertError(message: "Организация не найдена")
                }
            default: break
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) {_ in}
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    // MARK: - @IBActions
    @IBAction private func statusChangeSegmentedControl(_ sender: UISegmentedControl) {
        switch statusSegmentedControl.selectedSegmentIndex {
        case 0:
            loginTextField.placeholder = "Введите логин"
            loginTextField.title = "Логин"
            loginTextField.selectedTitle = "Логин"
        case 1:
            loginTextField.placeholder = "Введите УНП"
            loginTextField.title = "УНП"
            loginTextField.selectedTitle = "УНП"
        default: break
        }
    }
    @IBAction private func signInButton(_ sender: UIButton) {
        let status = statusSegmentedControl.selectedSegmentIndex
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        if checkSignInDatas(status, login, password) {
            switch status {
            case 0:
                if validIndividual(login, password) {
                    passwordTextField.text = ""
                    self.login = login
                    performSegue(withIdentifier: "toHomeSegue", sender: nil)
                } else {
                    showAlertError(message: "Неверный логин и/или пароль.")
                }
            case 1:
                if validOrganization(login, password) {
                    passwordTextField.text = ""
                    self.login = login
                    performSegue(withIdentifier: "toHomeSegue", sender: nil)
                } else {
                    showAlertError(message: "Неверный логин и/или пароль.")
                }
            default: break
            }
        } else {
         //   print("datas error")
        }
    }
    @IBAction private func registrationButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignUpSegue", sender: nil)
    }
    @IBAction private func forgotPasswordButton(_ sender: UIButton) {
        let status = statusSegmentedControl.selectedSegmentIndex
        let login = loginTextField.text ?? ""
        showAlertForgotPassword(status, login)
    }
    // MARK: - unwind @IBActions
    @IBAction private func unwindToSignInFromRegistration(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToSignInVCSegue" else {return}
        guard segue.destination as? SignUpViewController != nil else {return}
    }
    @IBAction private func unwindToSignInFromEndRegistation(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindFomEndToSignInVCSegue" else {return}
        guard segue.destination as? EndOfSignUpViewController != nil else {return}
    }
    @IBAction private func unwindToSignInFromHome(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindFromHomeToSignInVCSegue" else {return}
        guard segue.destination as? OtherPageHomeViewController != nil else {return}
    }
}
// MARK: - Extensions
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UITextField {
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
