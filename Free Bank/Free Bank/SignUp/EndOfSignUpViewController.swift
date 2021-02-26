//
//  EndOfSignUpViewController.swift
//  Free Bank
//
//  Created by Пользователь on 25.02.21.
//

import UIKit

class EndOfSignUpViewController: UIViewController {

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

        print("\(status) \(name) \(email) \(login) \(password)")
    }

}
