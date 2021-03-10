//
//  CreditsViewController.swift
//  Free Bank
//
//  Created by Пользователь on 1.03.21.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var missingCreditsLabel: UILabel!
    @IBOutlet private weak var creditsTableView: UITableView!
    
    private var individual: Individual?
    private var organization: Organization?
    
    private var credits: [Credit] = []
    private var creditForTransfer: Credit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transparentNavBar(navigationBar)
        
        creditsTableViewConfigurations()
        
        updateCredits()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCredits()
        if credits.isEmpty {
            creditsTableView.isHidden = true
            missingCreditsLabel.isHidden = false
        } else {
            creditsTableView.isHidden = false
            missingCreditsLabel.isHidden = true
        }
        
        DispatchQueue.main.async {
            self.creditsTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toCreditSegue" {
            if let destinationVC = segue.destination as? CreditViewController {
                destinationVC.setCredit(creditForTransfer!)
            }
        }

        guard segue.identifier == "toNewCreditSegue" else { return }
        guard let destinationVC = segue.destination as? NewCreditViewController else { return }
        destinationVC.setIndividual(individual)
        destinationVC.setOrganization(organization)

    }
    
    func updateCredits() {
        let accs = individual?.credits ?? organization?.credits
        credits = Array ( accs as! Set<Credit> )
        credits.sort(){
            return $0.idNumber < $1.idNumber
        }
    }
    
    func creditsTableViewConfigurations(){
        
        creditsTableView.backgroundColor = .clear
        
        creditsTableView.register(CreditTableViewCell.nib(), forCellReuseIdentifier: CreditTableViewCell.identifier)
        
        creditsTableView.delegate = self
        creditsTableView.dataSource = self
        
    }
    
    @IBAction func unwindToCreditsVCFromNewCreditVC(segue:UIStoryboardSegue){
        guard segue.identifier == "unwindToCreditsFromNewCreditSegue" else {return}
        guard let _ = segue.destination as? NewCreditViewController else {return}
    }
    
    @IBAction func unwindToCreditsVCFromConfirmCreditVC(segue:UIStoryboardSegue){
        guard segue.identifier == "unwindToCreditsFromConfirmCreditSegue" else {return}
        guard let _ = segue.destination as? ConfirmationCreditViewController else {return}
    }
    
    @IBAction func unwindToCreditsVCFromCreditVC(segue:UIStoryboardSegue){
        guard segue.identifier == "unwindToCreditsFromCreditSegue" else {return}
        guard let _ = segue.destination as? CreditViewController else {return}
      
    }
    
    @IBAction func addCredit(_ sender: UIButton) {
        
        if credits.count > 1 {
            showAlertError(message: "На одного пользователя не может быть оформлено не более 2 кредитов")
        }
        else {
            performSegue(withIdentifier: "toNewCreditSegue", sender: nil)
        }
    }
    
}

extension CreditsViewController: OrgIndivid {
    
    func setIndividual(_ individ: Individual?){
        self.individual = individ
    }
    
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
}

extension CreditsViewController: UITableViewDelegate {}

extension CreditsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.creditsTableView.dequeueReusableCell(withIdentifier: CreditTableViewCell.identifier) as? CreditTableViewCell {
            cell.selectionStyle = .none
            cell.configure(credits[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        creditForTransfer = credits[indexPath.row]
        performSegue(withIdentifier: "toCreditSegue", sender: nil)
    }
}
