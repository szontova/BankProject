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
        
        depositsTableViewConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        updateDeposits()
        DispatchQueue.main.async {
            self.depositsTableView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toNewDepositSegue" else { return }
        guard let destinationVC = segue.destination as? NewDepositViewController else { return }
        destinationVC.setIndividual(individual)
        destinationVC.setOrganization(organization)
    }
    
    func updateDeposits() {
        let accs = individual?.deposits ?? organization?.deposits
        deposits = Array ( accs as! Set<Deposit> )
        deposits.sort(){
            return $0.idNumber < $1.idNumber
        }
    }
    
    
    func depositsTableViewConfigurations(){
        
        depositsTableView.backgroundColor = .clear
        
        depositsTableView.register(DepositTableViewCell.nib(), forCellReuseIdentifier: DepositTableViewCell.identifier)
        
        depositsTableView.delegate = self
        depositsTableView.dataSource = self
        
    }
    
    @IBAction func unwindToDepositsVCFromNewDepositVC(segue:UIStoryboardSegue){
        guard segue.identifier == "unwindToDepositsFromNewDepositSegue" else {return}
        guard let _ = segue.destination as? NewDepositViewController else {return}
    }
    
    
    @IBAction func unwindToDepositsVCFromConfirmDepositVC(segue:UIStoryboardSegue){
        guard segue.identifier == "unwindToDepositsFromConfirmDepositSegue" else {return}
        guard let _ = segue.destination as? ConfirmationDepositViewController else {return}
    }
    
    @IBAction func addDepositButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toNewDepositSegue", sender: nil)
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
        if let cell = self.depositsTableView.dequeueReusableCell(withIdentifier: DepositTableViewCell.identifier) as? DepositTableViewCell {
            cell.selectionStyle = .none
            //cell.configure()
            cell.configure(deposits[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
