//
//  SignUpViewController.swift
//  Free Bank
//
//  Created by Пользователь on 4.02.21.
//

import UIKit

class SignUpViewController: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    
    private var activeTextField : UITextField?
    private var isMoving = false
    
    //MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //MARK: - OverrideMethods
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
    
    //MARK: - @IBActions
    @IBAction func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if let activeTextField = activeTextField {
                
                let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
                
                let topOfKeyboard = self.view.frame.height - keyboardSize.height
                
                let inset =  bottomOfTextField - topOfKeyboard
                if inset > 0 && !isMoving {
                    self.view.frame.origin.y -= (inset + 50)//keyboardSize.height
                    isMoving = true
                }
            }
        }
    }

    @IBAction func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        isMoving = false
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

        if checkSignUpDatas(status, name, email, login, password, repeatPassword) {
            performSegue(withIdentifier: "endRegSegue", sender: nil)
        }
    }
    
    @IBAction func unwindToSignUpFromEndSignUp(segue: UIStoryboardSegue){
        guard segue.identifier == "unwindFromEndToSignUpVCSegue" else {return}
        guard let _ = segue.destination as? EndOfSignUpViewController else {return}
    }
}
//MARK: - Extensions
extension SignUpViewController: UITextFieldDelegate{
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
