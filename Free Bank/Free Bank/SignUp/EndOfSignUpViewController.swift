//
//  EndOfSignUpViewController.swift
//  Free Bank
//
//  Created by Пользователь on 25.02.21.
//

import UIKit

class EndOfSignUpViewController: UIViewController {

    @IBOutlet weak var codeWordLabel: UITextField!
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
        let codeWord = codeWordLabel.text ?? ""
        if codeWord.isEmpty {
            showAlertError(message: "Введите кодовое слово")
            print("codeword empty")
            return
        } else {
            if let _ = name, let _ = email, let _ = login, let _ = password {
               // print("\(status) \(name) \(email) \(login) \(password) \(codeWord)")
                switch status {
                case 0:
                    print("add person")
                    
                 //   addIndividal(name!, email!, login!, password!, codeWord)
                performSegue(withIdentifier: "unwindFomEndToSignInVCSegue", sender: nil)
                case 1:
                    print("add org")
                 //   addOrganization(name!, email!, login!, password!, codeWord)
                    performSegue(withIdentifier: "unwindFomEndToSignInVCSegue", sender: nil)
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
