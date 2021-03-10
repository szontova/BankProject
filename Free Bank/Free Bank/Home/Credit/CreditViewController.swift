//
//  CreditViewController.swift
//  Free Bank
//
//  Created by Пользователь on 4.03.21.
//

import UIKit

class CreditViewController: UIViewController {
    
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var creditNumberLabel: UILabel!
    @IBOutlet private weak var accountNumberLabel: UILabel!
    @IBOutlet private weak var balanceAccountLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var procentLabel: UILabel!
    @IBOutlet private weak var beginDateLabel: UILabel!
    @IBOutlet private weak var monthlyPayLabel: UILabel!
    @IBOutlet private weak var endDateLabel: UILabel!
    @IBOutlet private weak var nextPayDateLabel: UILabel!
    
    private var credit: Credit?
    
    func setCredit(_ credit: Credit) {
        self.credit = credit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavBar(navigationBar)
        if let cred = credit {
            creditNumberLabel.text = String(cred.idNumber)
            if let acc = cred.account{
                accountNumberLabel.text = "Счёт: \(acc.idNumber!)"
                balanceAccountLabel.text = Util.getIntBYRbyString(acc.balance)
            }
            amountLabel.text = Util.getIntBYRbyString(cred.amount)
            procentLabel.text = "\(cred.procent) %"
         
            beginDateLabel.text = Util.getddMMyyyyDateString(cred.date!)
            let endDate = Util.getIntervalDate(cred.date!, Float(cred.term)/12)
            endDateLabel.text = Util.getddMMyyyyDateString(endDate)
            
            monthlyPayLabel.text = Util.getIntBYRbyString(Util.calculateMonthlyPay(amount: cred.amount, term: cred.term, procent: cred.procent))
            
            nextPayDateLabel.text = Util.getddMMyyyyDateString(Util.getIntervalDate(cred.date!,1/12))
        }
    }
    @IBAction func payOffButton(_ sender: UIButton) {
    }
    @IBAction func TransferMoneyButton(_ sender: UIButton) {
    }
}
