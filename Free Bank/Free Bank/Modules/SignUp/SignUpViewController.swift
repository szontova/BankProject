//
//  SignUpViewController.swift
//  Free Bank
//
//  Created by Пользователь on 4.02.21.
//

import SkyFloatingLabelTextField
import UIKit

class SignUpViewController: UIViewController {

    // MARK: - @IBOutlets
    @IBOutlet private weak var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var loginTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var repeatPasswordTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var statusSegmentedControl: UISegmentedControl!
    private var activeTextField: UITextField?
    private var isMoving = false
    // MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        textFieldsConfiguration()
    }
    // MARK: - OurMethods
    func textFieldsConfiguration() {
        let textFields:[SkyFloatingLabelTextField] = [self.nameTextField, self.loginTextField, self.passwordTextField, self.repeatPasswordTextField, self.emailTextField]
        for tf in textFields {
            tf.font = .systemFont(ofSize: 16.0)
            tf.placeholderFont = .systemFont(ofSize: 16.0)
            tf.titleFont = .boldSystemFont(ofSize: 14.0)
        }
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    // MARK: - OverrideMethods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "endRegSegue" else { return }
        guard let destinationVC = segue.destination as? EndOfSignUpViewController else { return }
        destinationVC.setName(nameTextField.text)
        destinationVC.setEmail(emailTextField.text)
        destinationVC.setLogin(loginTextField.text)
        destinationVC.setPassword(passwordTextField.text)
        destinationVC.setStatus(statusSegmentedControl.selectedSegmentIndex)
    }
    // MARK: - @IBActions
    @IBAction private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if let activeTextField = activeTextField {
                let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY
                let topOfKeyboard = self.view.frame.height - keyboardSize.height
                let inset =  bottomOfTextField - topOfKeyboard
                if inset > 0 && !isMoving {
                    self.view.frame.origin.y -= (inset + 50)
                    isMoving = true
                }
            }
        }
    }
    @IBAction private func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        isMoving = false
    }
    @IBAction private func statusChangeSegmentedControl(_ sender: UISegmentedControl) {
        switch statusSegmentedControl.selectedSegmentIndex {
        case 0:
            nameTextField.placeholder = "Введите ФИО"
            nameTextField.title = "ФИО"
            nameTextField.selectedTitle = "ФИО"
            
            loginTextField.placeholder = "Введите логин"
            loginTextField.title = "Логин"
            loginTextField.selectedTitle = "Логин"
        case 1:
            nameTextField.placeholder = "Введите название компании"
            nameTextField.title = "название компании"
            nameTextField.selectedTitle = "название компании"
            
            loginTextField.placeholder = "Введите УНП"
            loginTextField.title = "УНП"
            loginTextField.selectedTitle = "УНП"
        default: break
        }
    }
    @IBAction private func signUpButton(_ sender: UIButton) {
        let status = statusSegmentedControl.selectedSegmentIndex
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let repeatPassword = repeatPasswordTextField.text ?? ""

        if checkSignUpDatas(status, name, email, login, password, repeatPassword) {
            performSegue(withIdentifier: "endRegSegue", sender: nil)
        }
    }
    @IBAction private func unwindToSignUpFromEndSignUp(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindFromEndToSignUpVCSegue" else {return}
        guard segue.destination as? EndOfSignUpViewController != nil else {return}
    }
    @IBAction private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if textField == self.repeatPasswordTextField {
                if text == "" ||  text != passwordTextField.text {
                    self.repeatPasswordTextField.errorMessage = "пароли не совпадают"
                    self.repeatPasswordTextField.placeholder = ""
                } else {
                    self.repeatPasswordTextField.errorMessage = ""
                    self.repeatPasswordTextField.title = ""
                    self.repeatPasswordTextField.selectedTitle = ""
                }
            } else if textField == self.passwordTextField {
                if text != "" && repeatPasswordTextField.text != "" {
                    if text != repeatPasswordTextField.text {
                        self.repeatPasswordTextField.errorMessage = "пароли не совпадают"
                        self.repeatPasswordTextField.placeholder = ""
                    } else {
                        self.repeatPasswordTextField.errorMessage = ""
                        self.repeatPasswordTextField.title = ""
                        self.repeatPasswordTextField.selectedTitle = ""
                    }
                }
            }
        }
    }
}
// MARK: - Extensions
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
      self.activeTextField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
      self.activeTextField = nil
    }
}
