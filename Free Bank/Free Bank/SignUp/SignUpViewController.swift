//
//  SignUpViewController.swift
//  Free Bank
//
//  Created by Пользователь on 4.02.21.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    
    private let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printAllIndividual()
        printAllOrganization()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        
        let status = statusSegmentedControl.selectedSegmentIndex
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let repeatPassword = repeatPasswordTextField.text ?? ""
       
        print("Sign Up", terminator: " ")
        if checkSignUpDatas(status, name, email, login, password, repeatPassword) {
            //проверка логина
            print("SignUpVC: datas right")
            
            switch status {
            case 0:
               addIndividal( name, email, login, password)
            case 1:
                addOrganization( name, email, login, password)
            default: break
            }
            
        }  else{ print("SignUpVC: datas error") }
        
        //add company or person to database
    }
    
       
}

extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
