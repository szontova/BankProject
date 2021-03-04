//
//  ConfirmationCreditViewController.swift
//  Free Bank
//
//  Created by Sasha Zontova on 3/3/21.
//

import UIKit

class ConfirmationCreditViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var monthlyPayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    private var amount: Int32?
    private var term: Int16?
    private var procent: Int16?
    private let date = Util.getDate()
    
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
        transparentNavBar(navigationBar)
        amountLabel.text = "\((amount ?? 0)/100) BYR"
        termLabel.text = "\(term ?? 0) месяцев"
        let monthlyPay = Util.calculateMonthlyPay(amount: amount!, term: term!, procent: 13)
        
        monthlyPayLabel.text = NSString(format: "%.2f BYR", Float(monthlyPay)/100) as String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateLabel.text = dateFormatter.string(for: date) ?? "00.00.0000"
        }
    
    @IBAction func confirmCreditButton(_ sender: UIButton) {
        addCredit( amount!, term!, procent!, date, individual, organization)
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
