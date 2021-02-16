//
//  SignUpViewController.swift
//  Free Bank
//
//  Created by Пользователь on 4.02.21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func checkDatas() -> Bool{
        let login = loginTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let repeatPassword = repeatPasswordTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        if name.isEmpty || login.isEmpty || password.isEmpty || repeatPassword.isEmpty || email.isEmpty {
            showAlertError(message: "Не все поля заполнены.")
            return false
        }
        
        return true
    }
    
    
    @IBAction func statusChangeSegmentedControl(_ sender: UISegmentedControl) {
        switch statusSegmentedControl.selectedSegmentIndex {
        case 0:
            nameLabel.text = "ФИО"
            nameTextField.placeholder = "Введите ФИО"
            loginLabel.text = "Логин"
            loginTextField.placeholder = "Введите логин"
        case 1:
            nameLabel.text = "Название компании"
            nameTextField.placeholder = "Введите название компании"
            loginLabel.text = "УНП"
            loginTextField.placeholder = "Введите УНП"
        default: break
        }
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        print("SignUp", terminator: " ")
        checkDatas() ? print("datas right") : print("datas error")
    }
    
}

extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
