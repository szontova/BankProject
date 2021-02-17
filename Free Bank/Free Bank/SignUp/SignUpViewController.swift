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
        print("Sign Up We are here")
    }
    
    func checkDatas() -> Bool{
        let name = nameTextField.text ?? ""
       // let email = emailTextField.text ?? ""
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
       // let repeatPassword = repeatPasswordTextField.text ?? ""
       
        
//        if name.isEmpty || login.isEmpty || password.isEmpty || repeatPassword.isEmpty || email.isEmpty {
//            showAlertError(message: "Не все поля заполнены.")
//            return false
//        }
        
        switch statusSegmentedControl.selectedSegmentIndex{
        
        case 0:
            
            if checkPersonName(name: name) {
                //use name
            }
            else { return false }
            
            if checkLogin(login: login) {
                //use login
            }
            else { return false }
            

        case 1:
            
            if checkOrgName(name: name){
                //use organization name
            }
            else { return false }
            
            if let _ = checkUNP(unp: login) {
                //use unp
            }
            else { return false }
            
        default: break
        }
        
        if checkPassword(password: password){
            //use password
        } else { return false }
        
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
