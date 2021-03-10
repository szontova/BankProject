//
//  DepositsViewController.swift
//  Free Bank
//
//  Created by Пользователь on 4.03.21.
//

import UIKit

class DepositsViewController: UIViewController {

    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var depositsTableView: UITableView!
    @IBOutlet private weak var missingDepositsLabel: UILabel!
    
    private var individual: Individual?
    private var organization: Organization?
    
    private var deposits: [Deposit] = []
    private var depositForTransfer: Deposit?
    
    //MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transparentNavBar(navigationBar)
        
        depositsTableViewConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        updateDeposits()
        
        if deposits.isEmpty {
            depositsTableView.isHidden = true
            missingDepositsLabel.isHidden = false
        } else {
            depositsTableView.isHidden = false
            missingDepositsLabel.isHidden = true
        }
        
        DispatchQueue.main.async {
            self.depositsTableView.reloadData()
        }
        
    }
    //MARK: - OverrideMethods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDepositSegue" {
            if let destinationVC = segue.destination as? DepositViewController {
                destinationVC.setDeposit(depositForTransfer!)
            }
        }
        
        guard segue.identifier == "toNewDepositSegue" else { return }
        guard let destinationVC = segue.destination as? NewDepositViewController else { return }
        destinationVC.setIndividual(individual)
        destinationVC.setOrganization(organization)
    }
    //MARK: -
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
    
    //MARK: - @IBActions
    
    @IBAction func addDepositButton(_ sender: UIButton) {
        if deposits.count > 1 {
            showAlertError(message: "На одного пользователя не может быть оформлено не более 2 депозитов")
        }
        else {
            performSegue(withIdentifier: "toNewDepositSegue", sender: nil)
        }
    }
    
    @IBAction func unwindToDepositsVCFromNewDepositVC(segue:UIStoryboardSegue){
        guard segue.identifier == "unwindToDepositsFromNewDepositSegue" else {return}
        guard let _ = segue.destination as? NewDepositViewController else {return}
    }
    
    @IBAction func unwindToDepositsVCFromDepositVC(segue:UIStoryboardSegue){
        guard segue.identifier == "unwindToDepositsFromDepositSegue" else {return}
        guard let _ = segue.destination as? DepositViewController else {return}
      
    }
    
    @IBAction func unwindToDepositsVCFromConfirmDepositVC(segue:UIStoryboardSegue){
        guard segue.identifier == "unwindToDepositsFromConfirmDepositSegue" else {return}
        guard let _ = segue.destination as? ConfirmationDepositViewController else {return}
    }
    
}
//MARK: - Extensions
extension DepositsViewController: OrgIndivid {
    
    func setIndividual(_ individ: Individual?){
        self.individual = individ
    }
    
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
}
//MARK: - TableView

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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        depositForTransfer = deposits[indexPath.row]
        performSegue(withIdentifier: "toDepositSegue", sender: nil)
    }
}
