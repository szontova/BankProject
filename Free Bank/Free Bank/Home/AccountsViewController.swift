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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transparentNavBar(navigationBar)
        
        accountsTableView.backgroundColor = .clear
        
        accountsTableView.register(AccountTableViewCell.nib(), forCellReuseIdentifier: "accountCell")
        
        accountsTableView.delegate = self
        accountsTableView.dataSource = self
        
        let accs = individual?.accounts ?? organization?.accounts
        accounts = Array ( accs as! Set<Account> )
        
    }

    @IBAction func addAccountButton(_ sender: UIButton) {
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
        
        if let cell = self.accountsTableView.dequeueReusableCell(withIdentifier: "accountCell") as? AccountTableViewCell {
            cell.configure(with: accounts[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
