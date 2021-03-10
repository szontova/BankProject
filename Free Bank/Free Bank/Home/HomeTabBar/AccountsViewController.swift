//
//  AccountsViewController.swift
//  Free Bank
//
//  Created by Пользователь on 1.03.21.
//

import UIKit

class AccountsViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var accountsTableView: UITableView!
    
    private var individual: Individual?
    private var organization: Organization?
    
    private var accounts: [Account] = []
    private var simpleAccounts: [Account] = []
    private var creditAccounts: [Account] = []
    private var depositAccounts: [Account] = []
    
    private var accountForTransfer: Account?
    
    //MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transparentNavBar(navigationBar)
    
        accountsTableViewConfigurations()
        
       // updateAccounts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateAccounts()
        DispatchQueue.main.async {
            self.accountsTableView.reloadData()
        }
    }
    
    //MARK: - OverrideMethods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toCardsSegue" else { return }
        guard let destinationVC = segue.destination as? CardsViewController else { return }
        destinationVC.setAccount(accountForTransfer)
    }

    //MARK: -
    func accountsTableViewConfigurations(){
        
        accountsTableView.backgroundColor = .clear
        
        accountsTableView.register(AccountTableViewCell.nib(), forCellReuseIdentifier: AccountTableViewCell.identifier)
        
        accountsTableView.delegate = self
        accountsTableView.dataSource = self
        
    }
    
    func updateAccounts() {
        let accs = individual?.accounts ?? organization?.accounts
        accounts = Array ( accs as! Set<Account> )
       
        accounts.sort(){
            return $0.idNumber! < $1.idNumber!
        }
        
        creditAccounts = accounts.filter({ acc in
            return Util.getAccCategory(acc) == "C"
        })
        
        simpleAccounts = accounts.filter({ acc in
            return Util.getAccCategory(acc) == "S"
        })
        
        depositAccounts = accounts.filter({ (acc) -> Bool in
            return Util.getAccCategory(acc) == "D"
        })
        
       // print(simpleAccounts)
       // print(depositAccounts)
       // print(creditAccounts)
    }
    
    func showATMAlert( acc: Account) {
        let alert = UIAlertController(title: "Банкомат", message: "Так как у нашего банка пока нет реальных банкоматов, вы можете положить деньги здесь. Введите необходимую сумму и она зачислится на данный счёт. Введите сумму до 2500 BYR.", preferredStyle: .alert)
      
        alert.view.tintColor = UIColor.black
        
        alert.addTextField(configurationHandler: {
            (textField) in
            textField.placeholder = "Введите сумму BYR"
            textField.keyboardType = .numberPad
            textField.borderStyle = UITextField.BorderStyle.roundedRect
        })
        
        for textField in alert.textFields! {
            let container = textField.superview
            let effectView = container?.superview?.subviews[0]
            if (effectView != nil) {
                container?.backgroundColor = UIColor.clear
                effectView?.removeFromSuperview()
            }
        }
        
        let okAction = UIAlertAction(title: "Зачислить", style: .default){ _ in
            let amount = (Int64(alert.textFields![0].text ?? "") ?? 0 ) * 100
            if amount > 250000 { self.showAlertError(message: "Сумма не должна превышать 2500 BYR")
            }
            else {
                acc.topUpAccountBalance(amount: amount)
                _  = self.addTransaction(Int64(amount), (nil, nil), (nil, acc))
                self.updateAccounts()
                DispatchQueue.main.async {
                    self.accountsTableView.reloadData()
                }
            }
           
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default){ _ in}
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
                
        present(alert, animated: true, completion: nil)
    }
    
    
    func showDeactivateAccountAlert (acc: Account) {
        let alert = UIAlertController(title: "Деактивация", message: "Вы уверены, что хотите деактивировать данный счёт? После деактивации счёта средства автоматически спишутся на счёт банка и возврату не подлежат.", preferredStyle: .alert)
      
        alert.view.tintColor = UIColor.black
        
        let okAction = UIAlertAction(title: "Деактивировать", style: .default){ _ in
            self.deleteAccount(acc)
            self.updateAccounts()
            DispatchQueue.main.async {
                    self.accountsTableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default){ _ in}
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
                
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - @IBActions
    
    @IBAction func unwindToAccountsVCFromAccCardsVC(segue:UIStoryboardSegue){
        guard segue.identifier == "unwindToAccFromAccCardsSegue" else {return}
        guard let _ = segue.destination as? CardsViewController else {return}
    }
    
    @IBAction func addAccountButton(_ sender: UIButton) {
     
        if simpleAccounts.count > 2 {
            showAlertError(message: "На одного пользователя может быть зарегистрировано не более 3 расчётных счетов ")
        }
        else {
            let accountNumber = generationIdAccount("S")
            let alert = UIAlertController(title: "", message: "\nНомер вашего нового счёта: \n" + accountNumber, preferredStyle: .alert)
                    
            let attributedString = NSAttributedString(string: "Подтверждения создания счёта", attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
                NSAttributedString.Key.foregroundColor : UIColor.black
            ])
            alert.setValue(attributedString, forKey: "attributedTitle")
                
            alert.view.tintColor = UIColor.black
                    
            let okAction = UIAlertAction(title: "Подтвердить", style: .default){ _ in
                self.addAccount(accountNumber, self.individual, self.organization)
                
                self.updateAccounts()
                
                DispatchQueue.main.async {
                    self.accountsTableView.reloadData()
                }
                
            }
            let cancelAction = UIAlertAction(title: "Отмена", style: .default){ _ in}
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
}

//MARK: - Extensions

extension AccountsViewController: OrgIndivid {
    
    func setIndividual(_ individ: Individual?){
        self.individual = individ
    }
    
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
    
}
//MARK: TableView

extension AccountsViewController: UITableViewDelegate {}

extension AccountsViewController: UITableViewDataSource {
    
    func setCountOfSection() -> Int {
        if creditAccounts.isEmpty && depositAccounts.isEmpty { return 1 }
        else if creditAccounts.isEmpty || depositAccounts.isEmpty { return 2 }
        else { return 3 }
    }
    
    func getAccount (row: Int, section: Int) -> Account{
        var acc: Account = accounts[0]
        if setCountOfSection() == 2 {
            if depositAccounts.count != 0 {
                if section == 0 { acc = depositAccounts[row]}
                else { acc = simpleAccounts[row] }
            }
            else {
                if section == 0 { acc = creditAccounts[row]}
                else { acc = simpleAccounts[row] }
            }
        } else if setCountOfSection() == 3 {
            if section == 0 { acc = creditAccounts[row] }
            if section == 1 { acc = depositAccounts[row] }
            if section == 2 { acc = simpleAccounts[row] }
        }
        else { acc = simpleAccounts[row] }
        return acc
    }
    
    // CountOfSections
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.backgroundColor = UIColor.init(red: 181/255, green: 150/255, blue: 142/255, alpha: 1.0)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        
        switch setCountOfSection() {
        case 1:
            if section == 0 { label.text = "Расчетные счета" }
        case 2:
            if depositAccounts.count != 0 {
                label.text = section == 0 ? "Депозитные счета" : "Расчетные счета"
            }
            else {
                label.text = section == 0 ? "Кредитные счета" : "Расчетные счета"
            }
        case 3:
            if section == 0 { label.text = "Кредитные счета" }
            if section == 1 { label.text = "Депозитные счета" }
            if section == 2 { label.text = "Расчетные счета" }
        default:
            print("Error in show section in AccountsViewController")
        }
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return setCountOfSection()
    }
    
    // CountOfCells
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if setCountOfSection() == 2 {
            if depositAccounts.count == 0{
                if section == 0 { return creditAccounts.count }
                return simpleAccounts.count
            }
            else {
                if section == 0 { return depositAccounts.count }
                return simpleAccounts.count
            }
        }
        if setCountOfSection() == 3 {
            if section == 0 { return creditAccounts.count }
            if section == 1 { return depositAccounts.count }
            return simpleAccounts.count
        }
        
        return simpleAccounts.count
    }
    
    // TableViewCell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.accountsTableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.identifier) as? AccountTableViewCell {
            
            cell.cellDelegate = self
            cell.selectionStyle = .none
            
            let acc = getAccount(row: indexPath.row, section: indexPath.section)
            var count = 0
            if Util.getAccCategory(acc) == "S" { count = simpleAccounts.count}
            cell.configure(with: acc, count: count)
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        accountForTransfer = getAccount(row: indexPath.row, section: indexPath.section)
        
        if Util.getAccCategory(accountForTransfer!) != "D" {
            performSegue(withIdentifier: "toCardsSegue", sender: nil)
        }
    }
    
}

//MARK: TableViewCellDelegate
extension AccountsViewController: AccountTableViewCellDelegate {
    func addMoney(cell: AccountTableViewCell, didTappedThe button: UIButton?) {
        guard let indexPath = accountsTableView.indexPath(for: cell) else  { return }
        showATMAlert(acc: getAccount(row: indexPath.row, section: indexPath.section))
    }
    
    func deactivateAccount(cell: AccountTableViewCell, didTappedThe button: UIButton?) {
        guard let indexPath = accountsTableView.indexPath(for: cell) else  { return }
        _ = getAccount(row: indexPath.row, section: indexPath.section)
        showDeactivateAccountAlert(acc: getAccount(row: indexPath.row, section: indexPath.section))
    }
    
}
