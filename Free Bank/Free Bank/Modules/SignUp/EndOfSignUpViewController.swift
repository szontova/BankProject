//
//  EndOfSignUpViewController.swift
//  Free Bank
//
//  Created by Пользователь on 25.02.21.
//

import UIKit

class EndOfSignUpViewController: UIViewController {

    // MARK: - @IBOutlets
    @IBOutlet weak var codeWordTextField: UITextField!
    private var status: Int?
    private var name: String?
    private var email: String?
    private var login: String?
    private var password: String?
    // MARK: - SetFunctions
    func setStatus(_ status: Int?) {
        self.status = status
    }
    func setName(_ name: String?) {
        self.name = name
    }
    func setEmail(_ email: String?) {
        self.email = email
    }
    func setLogin(_ login: String?) {
        self.login = login
    }
    func setPassword(_ password: String?) {
        self.password = password
    }
    // MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(NewTransactionViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewTransactionViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // MARK: - OverrideMethods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // MARK: - @IBActions
    @IBAction func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let bottomOfTextField = codeWordTextField.convert(codeWordTextField.bounds, to: self.view).maxY
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            let inset =  bottomOfTextField - topOfKeyboard
            if inset > 0 && self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (inset + 50)
            }
        }
    }
    @IBAction func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    @IBAction func endOgSignUpButton(_ sender: Any) {
        let codeWord = codeWordTextField.text ?? ""
        if codeWord.isEmpty {
            showAlertError(message: "Введите кодовое слово")
            return
        } else {
            if name != nil && email != nil && login != nil && password != nil {
                switch status {
                case 0:
                    addIndividal(name!, email!, login!, password!, codeWord)
                    showAlertMessageWithSegue(message: "\nРегистрация успешно завершена", segue: "unwindFomEndToSignInVCSegue")
                case 1:
                    addOrganization(name!, email!, login!, password!, codeWord)
                    showAlertMessageWithSegue(message: "\nРегистрация успешно завершена", segue: "unwindFomEndToSignInVCSegue")
                default: break
                }
            }
        }
    }
}
// MARK: - Extensions
extension EndOfSignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
