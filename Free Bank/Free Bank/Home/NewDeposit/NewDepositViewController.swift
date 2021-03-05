//
//  NewDepositViewController.swift
//  Free Bank
//
//  Created by Пользователь on 5.03.21.
//

import UIKit

class NewDepositViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var termLabel: UILabel!

    @IBOutlet weak var termSlider: UISlider!
    @IBOutlet weak var revocableSwitch: UISwitch!
    
    
    private var individual: Individual?
    private var organization: Organization?
    
    private var amount = 0
    private var term = 0
    private var revocable = false
    private let procent = 17
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transparentNavBar(navigationBar)
        // Do any additional setup after loading the view.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toConfirmationDepositSegue" else { return }
        guard let destinationVC = segue.destination as? ConfirmationDepositViewController else { return }
        destinationVC.setAmount(Int64(amount * 100))
        destinationVC.setTerm(Int16(term))
        destinationVC.setProcent(Int16(procent))
        destinationVC.setRevocable(revocable)
        destinationVC.setIndividual(individual)
        destinationVC.setOrganization(organization)
    }
    
    @IBAction func unwindToNewDepositFromConfirmationDeposit(segue: UIStoryboardSegue){
        guard segue.identifier == "unwindToNewDepositFromConfirmSegue" else {return}
        guard let _ = segue.destination as? ConfirmationDepositViewController else {return}
    }
    
    @IBAction func termSlider(_ sender: UISlider) {
        term = Int(Util.setValueOfSlider(slider: termSlider, step: 1))
        termLabel.text = String(format: "%g", Util.setValueOfSlider(slider: termSlider, step: 1)) + " \(Util.defineWordForDepositTerm(term: term))"
    }
    
    @IBAction func addDepositButton(_ sender: UIButton) {
        amount = Int.parse(amountTextField.text ?? "") ?? 0
        term = (Int.parse(termLabel.text ?? "") ?? 0) * 12
        print(term)
        performSegue(withIdentifier: "toConfirmationDepositSegue", sender: nil)
    }
    
    @IBAction func revocableSwitch(_ sender: UISwitch) {
         if revocableSwitch.isOn { revocable = true }
    }

}

extension NewDepositViewController: OrgIndivid {
    
    func setIndividual(_ individ: Individual?){
        self.individual = individ
    }
    
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
    
}
