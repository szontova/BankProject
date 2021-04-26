//
//  HomeTabBarController.swift
//  Free Bank
//
//  Created by Пользователь on 24.02.21.
//

import UIKit

class HomeTabBarController: UITabBarController {
    // MARK: - @IBOutlets
    private var status: Int?
    private var login: String?
    private var individual: Individual?
    private var organization: Organization?
        
    func setLogin(_ login: String) {
        self.login = login
    }
    func setStatus(_ status: Int?) {
        self.status = status
    }
    // MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        if let log = login {
        switch status {
        case 0:
            self.individual = CoreDataConstants.db.findIndivididual(by: log)
        case 1:
            self.organization = CoreDataConstants.db.findOrganization(by: log)
        default: break
        }
        }
        for VC in self.viewControllers! {
         let vc = VC as? OrgIndivid
            vc?.setIndividual(self.individual)
            vc?.setOrganization(self.organization)
        }
    }
}
