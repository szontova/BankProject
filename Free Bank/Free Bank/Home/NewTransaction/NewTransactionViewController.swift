//
//  NewTransactionViewController.swift
//  Free Bank
//
//  Created by Пользователь on 8.03.21.
//

import UIKit

class NewTransactionViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    private var individual: Individual?
    private var organization: Organization?
    private var senderType: (Bool, Bool) = (false,false)
    private var receiverType: (Bool, Bool) = (false,false)
    
    func setSender( card: Bool,  acc: Bool){
        self.senderType = (card, acc)
    }
    
    func setReceiver( card: Bool,  acc: Bool){
        self.receiverType = (card, acc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transparentNavBar(navigationBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("\(individual) \(organization) \(senderType) \(receiverType)")
    }

}

extension NewTransactionViewController: OrgIndivid{
    func setIndividual(_ individ: Individual?) {
        self.individual = individ
    }
    
    func setOrganization(_ org: Organization?) {
        self.organization = org
    }
}
