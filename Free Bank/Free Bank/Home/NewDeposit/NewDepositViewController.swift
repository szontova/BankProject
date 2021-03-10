//
//  NewDepositViewController.swift
//  Free Bank
//
//  Created by Пользователь on 5.03.21.
//

import UIKit

class NewDepositViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet private weak var navigationBar: UINavigationBar!
    
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var termLabel: UILabel!

    @IBOutlet private weak var termSlider: UISlider!
    @IBOutlet private weak var revocableSwitch: UISwitch!
    
    private var individual: Individual?
    private var organization: Organization?
    
    private var amount = 0
    private var term = 0
    private var revocable = false
    private let procent = 17
    
    //MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()

        transparentNavBar(navigationBar)
        // Do any additional setup after loading the view.
    }
    
    //MARK: - OverrideMethods
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
    
    //MARK: - @IBActions
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
        if !Range(100...10000).contains(amount) {
            showAlertError(message: "Введите значение суммы от 100 до 10000 BYR.")
            return
        }
        term = (Int.parse(termLabel.text ?? "") ?? 0) * 12
        if revocableSwitch.isOn { revocable = true }
        else { revocable = false }
        performSegue(withIdentifier: "toConfirmationDepositSegue", sender: nil)
    }
    
}
//MARK: - Extensions
extension NewDepositViewController: OrgIndivid {
    
    func setIndividual(_ individ: Individual?){
        self.individual = individ
    }
    
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
    
}
