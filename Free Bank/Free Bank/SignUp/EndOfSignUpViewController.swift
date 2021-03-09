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
        NotificationCenter.default.addObserver(self, selector: #selector(NewTransactionViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewTransactionViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let bottomOfTextField = codeWordTextField.convert(codeWordTextField.bounds, to: self.view).maxY;
            
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            let inset =  bottomOfTextField - topOfKeyboard
            if inset > 0 && self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= (inset + 50)//keyboardSize.height
            }
        }
    }

    @IBAction func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
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
