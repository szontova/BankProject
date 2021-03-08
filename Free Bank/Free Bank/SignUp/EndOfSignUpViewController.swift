//
//  EndOfSignUpViewController.swift
//  Free Bank
//
//  Created by Пользователь on 25.02.21.
//

import UIKit

class EndOfSignUpViewController: UIViewController {

    @IBOutlet weak var codeWordTextField: UITextField!
    private var status: Int?
    private var name: String?
    private var email: String?
    private var login: String?
    private var password: String?
  
    func setStatus(_ status: Int?){
        self.status = status
    }
    
    func setName(_ name: String?){
        self.name = name
    }
    
    func setEmail(_ email: String?){
        self.email = email
    }
    
    func setLogin(_ login: String?){
        self.login = login
    }
    
    func setPassword(_ password: String?){
        self.password = password
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func EndOgSignUpButton(_ sender: Any) {
        let codeWord = codeWordTextField.text ?? ""
        if codeWord.isEmpty {
            showAlertError(message: "Введите кодовое слово")
            return
        } else {
            if let _ = name, let _ = email, let _ = login, let _ = password {
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

extension EndOfSignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
