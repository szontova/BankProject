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
        
        accountsTableView.delegate = self
        accountsTableView.dataSource = self
        
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
        let count = individual?.accounts?.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.accountsTableView.dequeueReusableCell(withIdentifier: "accountCell")! as UITableViewCell
       // let acc =  individual?.accounts
       
        cell.textLabel?.text = "la"
        return cell
    }
}
