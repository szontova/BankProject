//
//  DepositViewController.swift
//  Free Bank
//
//  Created by Пользователь on 5.03.21.
//

import UIKit

class DepositViewController: UIViewController {
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var depositNumberLabel: UILabel!
    @IBOutlet private weak var accountNumberLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var procentLabel: UILabel!
    @IBOutlet private weak var revocableLabel: UILabel!
    @IBOutlet private weak var beginDateLabel: UILabel!
    @IBOutlet private weak var endDateLabel: UILabel!
    @IBOutlet private weak var withdrawMoneyButton: UIButton!
    
    private var deposit: Deposit?
    
    func setDeposit(_ deposit: Deposit){
        self.deposit = deposit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transparentNavBar(navigationBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let dep = deposit {
            depositNumberLabel.text = String(dep.idNumber)
            accountNumberLabel.text = "Счёт: \(dep.account!.idNumber!)"
            amountLabel.text = Util.getIntBYRbyString(dep.amount)
            procentLabel.text = "\(dep.procent) %"
            
            switch dep.revocable{
            case true:
                revocableLabel.text = "отзывной"
                withdrawMoneyButton.isHidden = false
            case false:
                revocableLabel.text = "безотзывной"
                withdrawMoneyButton.isHidden = true
            }
            
            beginDateLabel.text = Util.getddMMyyyyDateString(dep.date!)
            let endDate = Util.getIntervalDate(dep.date!, Float(dep.term)/12)
            endDateLabel.text = Util.getddMMyyyyDateString(endDate)
        }
      
    }
    @IBAction func withdrawMoneyAction(_ sender: UIButton) {
        
    }
    
}
