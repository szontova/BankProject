//
//  ConfirmationCreditViewController.swift
//  Free Bank
//
//  Created by Sasha Zontova on 3/3/21.
//

import UIKit

class ConfirmationCreditViewController: UIViewController {
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var monthlyPayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    private var amount: Int32?
    private var term: Int16?
    private var procent: Int16?
    
    private var individual: Individual?
    private var organization: Organization?

    func setAmount(_ amount: Int32?){
        self.amount = amount
    }
    
    func setTerm(_ term: Int16?){
        self.term = term
    }
    
    func setProcent(_ procent: Int16?){
        self.procent = procent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountLabel.text = "\(amount ?? 0) BYR"
        termLabel.text = "\(term ?? 0) месяцев"
        let monthlyPay = Util.calculateMonthlyPay(amount: amount!, term: term!, procent: 13)
        
        monthlyPayLabel.text = NSString(format: "%.2f BYR", Float(monthlyPay)/100) as String
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
