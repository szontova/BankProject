//
//  TransfersViewController.swift
//  Free Bank
//
//  Created by Пользователь on 1.03.21.
//

import UIKit

class TransfersViewController: UIViewController {

    private var individual: Individual?
    private var organization: Organization?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension TransfersViewController: OrgIndivid {
    
    func setIndividual(_ individ: Individual?){
        self.individual = individ
    }
    
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
    
}
