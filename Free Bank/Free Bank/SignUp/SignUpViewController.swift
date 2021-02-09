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
        
        changeSegmentedControl()
      
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func changeSegmentedControl() {
        statusSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        statusSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    }
    
    func checkDatas() -> Bool{
        let login = loginTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let repeatPassword = repeatPasswordTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        if name.isEmpty || login.isEmpty || password.isEmpty || repeatPassword.isEmpty || email.isEmpty {
        showAlertError(title: "Ошибка", message: "Не все поля заполнены.")
            return false
        }
        
        return true
    }
    
    func showAlertError(title: String, message: String){
        let alertError = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertError.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
        
        let attributedStringForTitle = NSAttributedString(string: title, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor : UIColor.red
        ])
        alertError.setValue(attributedStringForTitle, forKey: "attributedTitle")
        
        let attributedStringForMessage = NSAttributedString(string: message, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ])
        alertError.setValue(attributedStringForMessage, forKey: "attributedMessage")
     
    
        let okAction = UIAlertAction(title: "OK", style: .default){_ in}
        okAction.setValue(UIColor.black, forKey: "titleTextColor")
        alertError.addAction(okAction)
        //поговорить по поводу полосочки
        present(alertError, animated: true, completion: nil)
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
