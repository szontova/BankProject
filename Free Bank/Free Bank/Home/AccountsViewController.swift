//
//  AccountsViewController.swift
//  Free Bank
//
//  Created by Пользователь on 1.03.21.
//

import UIKit

class AccountsViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var accountsTableView: UITableView!
    
    private var individual: Individual?
    private var organization: Organization?
    
    private var accounts: [Account] = []
    private var simpleAccounts: [Account] = []
    private var creditAccounts: [Account] = []
    private var depositAccounts: [Account] = []
    
    private var accountForTransfer: Account?
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toCardsSegue" else { return }
        guard let destinationVC = segue.destination as? CardsViewController else { return }
        destinationVC.setAccount(accountForTransfer)
    }

    
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
            return getAccCategory(acc) == "C"
        })
        
        simpleAccounts = accounts.filter({ acc in
            return getAccCategory(acc) == "S"
        })
        
        depositAccounts = accounts.filter({ (acc) -> Bool in
            return getAccCategory(acc) == "D"
        })
        
       // print(simpleAccounts)
       // print(depositAccounts)
       // print(creditAccounts)
    }

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

extension AccountsViewController: OrgIndivid {
    
    func setIndividual(_ individ: Individual?){
        self.individual = individ
    }
    
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
    
}

extension AccountsViewController: UITableViewDelegate {}

extension AccountsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.accountsTableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.identifier) as? AccountTableViewCell {
            cell.selectionStyle = .none
            cell.configure(with: accounts[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        accountForTransfer = accounts[indexPath.row]
        if getAccCategory(accountForTransfer!) != "D" {
            performSegue(withIdentifier: "toCardsSegue", sender: nil)
        }
    }
}
