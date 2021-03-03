//
//  ConfirmationCreditViewController.swift
//  Free Bank
//
//  Created by Sasha Zontova on 3/3/21.
//

import UIKit

class ConfirmationCreditViewController: UIViewController {

    private var amount: Int64?
    private var term: Int64?
    private var procent: Int16?
    
    private var individual: Individual?
    private var organization: Organization?

    func setAmount(_ amount: Int64?){
        self.amount = amount
    }
    
    func setTerm(_ term: Int64?){
        self.term = term
    }
    
    func setProcent(_ procent: Int16?){
        self.procent = procent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func confirmCreditButton(_ sender: UIButton) {
        addCredit(amount: amount!, term: term!, procent:  procent!, individual, organization)
        //print(individual?.credits)
        performSegue(withIdentifier: "unwindToCreditsFromConfirmCreditSegue", sender: nil)
    }
    
}

extension ConfirmationCreditViewController: OrgIndivid {
    
    func setIndividual(_ individ: Individual?){
        self.individual = individ
    }
    
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
    
}
