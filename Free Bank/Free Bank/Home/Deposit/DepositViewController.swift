//
//  DepositViewController.swift
//  Free Bank
//
//  Created by Пользователь on 5.03.21.
//

import UIKit

class DepositViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var depositNumberLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var procentLabel: UILabel!
    @IBOutlet weak var revocableLabel: UILabel!
    @IBOutlet weak var beginDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var withdrawMoneyButton: UIButton!
    
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
