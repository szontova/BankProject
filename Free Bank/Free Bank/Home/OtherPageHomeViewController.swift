//
//  OtherPageHomeViewController.swift
//  Free Bank
//
//  Created by Пользователь on 27.02.21.
//

import UIKit

class OtherPageHomeViewController: UIViewController {

    private var individual: Individual?
    private var organization: Organization?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension OtherPageHomeViewController: OrgIndivid {
    
    func setIndividual(_ individ: Individual?){
        self.individual = individ
    }
    
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
}
