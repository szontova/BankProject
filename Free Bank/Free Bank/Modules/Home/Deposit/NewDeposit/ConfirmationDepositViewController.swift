//
//  ConfirmationDepositViewController.swift
//  Free Bank
//
//  Created by Пользователь on 5.03.21.
//

import UIKit

class ConfirmationDepositViewController: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var procentLabel: UILabel!
    @IBOutlet private weak var termLabel: UILabel!
    @IBOutlet private weak var revocableLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    private var amount: Int64?
    private var term: Int16?
    private var procent: Int16?
    private var revocable: Bool?
    private let date = MyCustomVC.getDate()
    private var individual: Individual?
    private var organization: Organization?

    func setAmount(_ amount: Int64?) {
        self.amount = amount
    }
    func setTerm(_ term: Int16?) {
        self.term = term
    }
    func setProcent(_ procent: Int16?) {
        self.procent = procent
    }
    func setRevocable(_ revocable: Bool) {
        self.revocable = revocable
    }
    // MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavBar(navigationBar)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        amountLabel.text = MyCustomVC.getIntBYRbyString(amount!)
        procentLabel.text = "\(procent ?? 0) %"
        let yearsTerm =  Int(term ?? 0) / 12
        termLabel.text = "\(yearsTerm) \(MyCustomVC.defineWordForDepositTerm(term: yearsTerm))"
        var revocableString = ""
        if let rev = revocable {
            if rev { revocableString = "отзывной" } else { revocableString = "безотзывной" }
        }
        revocableLabel.text = revocableString
        dateLabel.text = MyCustomVC.getddMMyyyyDateString(date)
    }
    // MARK: - @IBActions
    @IBAction private func confirmDepositButton(_ sender: UIButton) {
        addDeposit(amount!, term!, procent!, date, revocable!, individual, organization)
        showAlertMessageWithSegue(message: "Депозит успешно оформлен", segue: "unwindToDepositsFromConfirmDepositSegue")
    }
}
// MARK: - Extensions
extension ConfirmationDepositViewController: OrgIndivid {
    func setIndividual(_ individ: Individual?) {
        self.individual = individ
    }
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
}
