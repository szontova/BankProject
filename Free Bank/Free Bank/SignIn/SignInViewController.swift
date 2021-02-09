//
//  ViewController.swift
//  Free Bank
//
//  Created by Пользователь on 1.02.21.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let touchErrorLabel = UITapGestureRecognizer(target: self, action: #selector(hidErrorLabel(_:)))
        
        touchErrorLabel.numberOfTapsRequired = 1
        touchErrorLabel.numberOfTouchesRequired = 1
        
        loginErrorLabel.addGestureRecognizer(touchErrorLabel)
        loginErrorLabel.isUserInteractionEnabled = true
        loginErrorLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func showAlertError(title: String, message: String){
        let alertError = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let attributedString = NSAttributedString(string: title, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor : UIColor.red
        ])
        alertError.setValue(attributedString, forKey: "attributedTitle")
        alertError.view.tintColor = UIColor.black
        let okAction = UIAlertAction(title: "OK", style: .default){_ in}
        alertError.addAction(okAction)
        present(alertError, animated: true, completion: nil)
    }
    
    func checkDatas() -> Bool{
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if login.isEmpty || password.isEmpty {
                showAlertError(title: "Ошибка", message: "Введите логин и пароль.")
            return false
                //loginErrorLabel.text = "Данные не введены"
                //loginErrorLabel.isHidden = false
            }
            
            else{
                loginErrorLabel.isHidden = true
                let allowLetters: Range<Character> = "A"..<"z"
                let allowSymbols: Set<Character> = [".","_"]
                
                if login.count < 8 || login.count > 50 {
                    showAlertError(title: "Ошибка", message: "Неверный формат логина. Проверьте данные.")
                    return false
                }
                else {
                    for symb in login {
                        if  (!allowLetters.contains(symb)) && (!allowSymbols.contains(symb)) {
                            showAlertError(title: "Ошибка", message: "Неверно введен логин. Проверьте данные.")
                            return false
                            //loginErrorLabel.text = "Данные введены неверно"
                            //loginErrorLabel.isHidden = false
                        }
                    }
                }
                
                //сделать пароль
//                else if  (!allowLetters.contains(symb)) && (!allowSymbols.contains(symb)) {
//                    showAlertError(title: "Ошибка", message: "Неверно введен логин. Проверьте данные.")
//                    //loginErrorLabel.text = "Данные введены неверно"
//                    //loginErrorLabel.isHidden = false
//                    break
//                }
        }
        return true
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        print("SignIn", terminator: " ")
        checkDatas() ? print("datas right") : print("datas error")
    }
    
    @IBAction func registrationButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignUpSegue", sender: nil)
    }
    
    @IBAction func unwindToSignInFromRegistration(segue: UIStoryboardSegue){
        guard segue.identifier == "unwindToSignInVCSegue" else {return}
        guard let _ = segue.destination as? SignUpViewController else {return}
    }
    
    @IBAction func hidErrorLabel(_ gesture: UITapGestureRecognizer){
        loginErrorLabel.isHidden.toggle()
        loginTextField.text = ""
    }
    
}

extension SignInViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
