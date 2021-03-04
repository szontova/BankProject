//
//  DepositsViewController.swift
//  Free Bank
//
//  Created by Пользователь on 4.03.21.
//

import UIKit

class DepositsViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var depositsTableView: UITableView!
    
    private var individual: Individual?
    private var organization: Organization?
    
    private var deposits: [Deposit] = []
    private var depositForTransfer: Deposit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transparentNavBar(navigationBar)
      
        updateDeposits()
        
        depositsTableViewConfigurations()
    }
    
    func updateDeposits() {
        let accs = individual?.deposit ?? organization?.deposit
        deposits = Array ( accs as! Set<Deposit> )
        deposits.sort(){
            return $0.idNumber! < $1.idNumber!
        }
    }
    
    func depositsTableViewConfigurations(){
        
        depositsTableView.backgroundColor = .clear
        
       // depositsTableView.register(DepositTableViewCell.nib(), forCellReuseIdentifier: DepositTableViewCell.identifier)
        
        depositsTableView.delegate = self
        depositsTableView.dataSource = self
        
    }
    
    @IBAction func addDepositButton(_ sender: UIButton) {
    }
    
}

extension DepositsViewController: OrgIndivid {
    
    func setIndividual(_ individ: Individual?){
        self.individual = individ
    }
    
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
}

extension DepositsViewController: UITableViewDelegate {}

extension DepositsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deposits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = self.depositsTableView.dequeueReusableCell(withIdentifier: DepositTableViewCell.identifier) as? DepositTableViewCell {
//            cell.selectionStyle = .none
//            cell.configure(deposits[indexPath.row])
//            return cell
//        }
        return UITableViewCell()
    }
}
