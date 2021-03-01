//
//  HomeTabBarController.swift
//  Free Bank
//
//  Created by Пользователь on 24.02.21.
//

import UIKit

protocol OrgIndivid: class {
    
    func setIndividual(_ individ: Individual?)
      
    func setOrganization(_ org: Organization?)
    
}

class HomeTabBarController: UITabBarController {

    private var status: Int?
    private var login: String?
    
    private var individual: Individual?
    private var organization: Organization?
    
    func setLogin(_ login: String){
        self.login = login
    }
    
    func setStatus(_ status: Int?){
        self.status = status
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (self.login ?? "Nothing")
        print (self.status ?? 0)
        
        if let log = login {
        switch status {
            case 0:
                self.individual = findIndivididual(by: log)
            case 1:
                self.organization = findOrganization(by: log)
            default: break
            }
            
        }
        
        for VC in self.viewControllers!  {
         let vc = VC as? OrgIndivid
            vc?.setIndividual(self.individual)
            vc?.setOrganization(self.organization)
        }
 
    }
    

}
