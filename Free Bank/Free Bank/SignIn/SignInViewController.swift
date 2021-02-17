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
    
    func showAlertForgotPassword(message: String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            
        let attributedString = NSAttributedString(string: "Восстановление пароля", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ])
        alert.setValue(attributedString, forKey: "attributedTitle")
                
        alert.view.tintColor = UIColor.black
        
        alert.addTextField(configurationHandler: {
            (textField) in
            textField.placeholder = self.loginTextField.placeholder
            textField.text = self.loginTextField.text ?? ""
            textField.borderStyle = UITextField.BorderStyle.roundedRect
        })
        
        alert.addTextField(configurationHandler: {
            (textField) in
            textField.placeholder = "Введите email"
            textField.borderStyle = UITextField.BorderStyle.roundedRect
        })
        
        for textField in alert.textFields! {
            let container = textField.superview
            let effectView = container?.superview?.subviews[0]
            if (effectView != nil) {
                container?.backgroundColor = UIColor.clear
                effectView?.removeFromSuperview()
            }
        }
                
        let okAction = UIAlertAction(title: "Восстановить", style: .default){ _ in }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default){ _ in}
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
                
        present(alert, animated: true, completion: nil)
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
        let status = statusSegmentedControl.selectedSegmentIndex
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        print("SignIn", terminator: " ")
        checkSignInDatas(status, login, password) ? print("datas right") : print("datas error")
        
        
    }
    
    @IBAction func registrationButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignUpSegue", sender: nil)
    }
    
    @IBAction func forgotPasswordButton(_ sender: UIButton) {
        showAlertForgotPassword(message: "Введите логин и email.")
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
