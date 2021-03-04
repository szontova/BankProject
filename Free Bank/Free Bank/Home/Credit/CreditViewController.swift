//
//  CreditViewController.swift
//  Free Bank
//
//  Created by Пользователь on 4.03.21.
//

import UIKit

class CreditViewController: UIViewController {
    
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet weak var creditNumberLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var balanceAccountLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var procentLabel: UILabel!
    @IBOutlet weak var beginDateLabel: UILabel!
    @IBOutlet weak var monthlyPayLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var countOfPaymentsLabel: UILabel!
    @IBOutlet weak var nextPayDateLabel: UILabel!
    
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
                balanceAccountLabel.text =  NSString(format: "%.2f BYR", Float(acc.balance)/100) as String
            }
            amountLabel.text = NSString(format: "%.2f BYR", Float(cred.amount)/100) as String
            procentLabel.text = "\(cred.procent) %"
         
            beginDateLabel.text = Util.getddMMyyyyDateString(cred.date!)
            let endDate = Util.getIntervalDate(cred.date!, Float(cred.term)/12)
            endDateLabel.text = Util.getddMMyyyyDateString(endDate)
            
            monthlyPayLabel.text = NSString(format: "%.2f BYR", Float(Util.calculateMonthlyPay(amount: cred.amount, term: cred.term, procent: cred.procent))/100) as String
        }
    }
    
}
