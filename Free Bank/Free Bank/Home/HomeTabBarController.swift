//
//  HomeTabBarController.swift
//  Free Bank
//
//  Created by Пользователь on 24.02.21.
//

import UIKit

class HomeTabBarController: UITabBarController {

    private var status: Int?
    private var login: String?
    
    func getLogin() -> String? {
        return self.login
    }
    
    func setLogin(_ login: String){
        self.login = login
    }
    
    func getStatus() -> Int? {
        return self.status
    }
    
    func setStatus(_ status: Int?){
        self.status = status
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (self.login ?? "Nothing")
        print (self.status ?? 0)
        if status == 0{
            //self.viewControllers?.remove(at: 0)
        }
        // Do any additional setup after loading the view.
    }
    

}
