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
    @IBOutlet weak var procentLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var revocableLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        amountLabel.text = Util.getIntBYRbyString(amount!)
        procentLabel.text = "\(procent ?? 0) %"
        let yearsTerm =  Int(term ?? 0) / 12
        termLabel.text = "\(yearsTerm) \(Util.defineWordForDepositTerm(term: yearsTerm))"
        var revocableString = ""
        if let rev = revocable {
            if rev { revocableString = "отзывной" }
            else { revocableString = "безотзывной" }
        }
        revocableLabel.text = revocableString
        dateLabel.text = Util.getddMMyyyyDateString(date)
    }
    
    @IBAction func confirmDepositButton(_ sender: UIButton) {
        addDeposit(amount!, term!, procent!, date, revocable!, individual, organization)
        showAlertMessageWithSegue(message: "Депозит успешно оформлен", segue: "unwindToDepositsFromConfirmDepositSegue")
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
