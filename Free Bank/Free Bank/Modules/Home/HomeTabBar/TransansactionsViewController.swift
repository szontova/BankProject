//
//  TransansactionsViewController.swift
//  Free Bank
//
//  Created by Пользователь on 1.03.21.
//

import CoreData
import UIKit

class TransansactionsViewController: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var senderSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var receiverSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var accountsPickerView: UIPickerView!
    @IBOutlet private weak var missingTransfersLabel: UILabel!
    @IBOutlet private weak var transactionsTableView: UITableView!
    private var individual: Individual?
    private var organization: Organization?

    private var accounts: [Account] = []
    private var transactions: [Transaction] = []
    // MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavBar(navigationBar)
        accountsPickerViewConfigurations()
        transactionsTableViewConfigurations()
    }
    override func viewWillAppear(_ animated: Bool) {
        updateAccounts()
        updateTransactions(accounts[0])
        updateTransactionsTableView(accounts[0])
        accountsPickerViewConfigurations()
    }
    // MARK: - OverrideMethods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toNewTransactionSegue" else { return }
        guard let destinationVC = segue.destination as? NewTransactionViewController else { return }
        destinationVC.setIndividual(individual)
        destinationVC.setOrganization(organization)
        if senderSegmentedControl.selectedSegmentIndex == 0 {
            destinationVC.setSender(card: true, acc: false)
        } else {
            destinationVC.setSender(card: false, acc: true)
        }
        if receiverSegmentedControl.selectedSegmentIndex == 0 {
            destinationVC.setReceiver(card: true, acc: false)
        } else {
            destinationVC.setReceiver(card: false, acc: true)
        }
    }
    // MARK: -
    func accountsPickerViewConfigurations() {
        accountsPickerView.delegate = self
        accountsPickerView.dataSource = self
    }
    func transactionsTableViewConfigurations() {
        transactionsTableView.backgroundColor = .clear
        transactionsTableView.register(TransactionTableViewCell.nib(), forCellReuseIdentifier: TransactionTableViewCell.identifier)
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
    }
    func updateAccounts() {
        let accs = individual?.accounts ?? organization?.accounts
        accounts = Array( accs as! Set<Account>)
        accounts.sort {
            return $0.idNumber! < $1.idNumber!
        }
    }
    func updateTransactions(_ account: Account) {
        transactions = Array( account.transactions as! Set<Transaction> )
        transactions.sort {
            return $0.date! > $1.date!
        }
    }
    func  updateTransactionsTableView( _ account: Account) {
        if transactions.isEmpty {
            missingTransfersLabel.isHidden = false
            transactionsTableView.isHidden = true
        } else {
            missingTransfersLabel.isHidden = true
            transactionsTableView.isHidden = false
        }
        DispatchQueue.main.async {
            self.transactionsTableView.reloadData()
        }
    }
    // MARK: - @IBActions
    @IBAction func unwindToTransactionsVCFromNewTransactionVC(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToTransactionsFromNewTransactionSegue" else {return}
        guard segue.destination as? NewTransactionViewController != nil else {return}
    }
    @IBAction func unwindToTransactionsVCFromConfirmTransactionVC(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToTransactionsFromConfirmTransactionSegue" else {return}
        guard segue.destination as? ConfirmationTransactionViewController != nil else {return}
    }
    @IBAction func addTransaction(_ sender: UIButton) {
        performSegue(withIdentifier: "toNewTransactionSegue", sender: nil)
    }
}
// MARK: - Extensions
extension TransansactionsViewController: OrgIndivid {
    func setIndividual(_ individ: Individual?) {
        self.individual = individ
    }
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
}

// MARK: PickerView
extension TransansactionsViewController: UIPickerViewDelegate {}
extension TransansactionsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accounts.count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.backgroundColor = UIColor.init(red: 181/255, green: 150/255, blue: 142/255, alpha: 1.0)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.layer.frame = CGRect(x: 0, y: 0, width: pickerView.frame.width - 20, height: 24 )
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.text = accounts[row].idNumber
        return label
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 27.5
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateTransactions(accounts[row])
        updateTransactionsTableView(accounts[row])
    }
}

// MARK: TableView
extension TransansactionsViewController: UITableViewDelegate {}
extension TransansactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.transactionsTableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier) as? TransactionTableViewCell {
            cell.selectionStyle = .none
            cell.configure(transactions[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
