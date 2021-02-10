//
//  ViewController.swift
//  Free Bank
//
//  Created by Пользователь on 1.02.21.
//

import UIKit

class SignInViewController: UIViewController {

    //MARK: - @IBOutlet
    
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var loginErrorLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
  
    //MARK: - LifeCycleMethods
    
    override func viewDidLoad() {
        //print("ViewDidLoad")
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        //print("loadView")
        //для файлов свёрстанных кодом
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // только появится
        // rf;lsq hfp rjulf gjgflftim yf 'rhfy
        super.viewWillAppear(animated)
        //print("viewWillAppear")
    }

    override func viewWillLayoutSubviews() {
        //constraints
        super.viewWillLayoutSubviews()
        //print("viewWillLayoutSubviews")
    }

    override func viewDidLayoutSubviews() {
        //
        super.viewDidLayoutSubviews()
        //print("viewDidLayoutSubviews")
    }

    override func viewDidAppear(_ animated: Bool) {
        //
        super.viewDidAppear(animated)
        //print("viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        //
        super.viewWillDisappear(animated)
        //print("viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        //
        super.viewDidDisappear(animated)
        //print("viewDidDisappear")
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        //print("viewWillTransition")
    }

    deinit {
        //print("deinit")
    }
    
//MARK: - Override methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//MARK: - Our methods
    
    
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
    
    //MARK:- @IBAction
    @IBAction func statusChangeSegmentedControl(_ sender: UISegmentedControl) {
        switch statusSegmentedControl.selectedSegmentIndex {
        case 0:
            loginLabel.text = "Логин"
            loginTextField.placeholder = "Введите логин"
        case 1:
    
            loginLabel.text = "УНП"
            loginTextField.placeholder = "Введите УНП"
        default: break
        }
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
    
}

//MARK:- Extensions
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
