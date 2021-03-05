//
//  ConfirmationDepositViewController.swift
//  Free Bank
//
//  Created by Пользователь on 5.03.21.
//

import UIKit

class ConfirmationDepositViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var amountLabel: UILabel!
    
    private var amount: Int64?
    private var term: Int16?
    private var procent: Int16?
    private var revocable: Bool?
    private let date = Util.getDate()
    
    private var individual: Individual?
    private var organization: Organization?

    func setAmount(_ amount: Int64?){
        self.amount = amount
    }
    
    func setTerm(_ term: Int16?){
        self.term = term
    }
    
    func setProcent(_ procent: Int16?){
        self.procent = procent
    }
    
    func setRevocable(_ revocable: Bool){
        self.revocable = revocable
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavBar(navigationBar)
        
        amountLabel.text = Util.getIntBYRbyString(amount!)
        
    }
    
    @IBAction func confirmDepositButton(_ sender: UIButton) {
        addDeposit(amount!, term!, procent!, date, revocable!, individual, organization)
        performSegue(withIdentifier: "unwindToDepositsFromConfirmDepositSegue", sender: nil)
    }
    
}

extension ConfirmationDepositViewController: OrgIndivid {
    
    func setIndividual(_ individ: Individual?){
        self.individual = individ
    }
    
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
    
}
