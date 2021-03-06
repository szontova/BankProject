//
//  NewCreditViewController.swift
//  Free Bank
//
//  Created by Sasha Zontova on 3/2/21.
//

import UIKit

class NewCreditViewController: UIViewController {

    // MARK: - @IBOutlets
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var amountSlider: UISlider!
    @IBOutlet private weak var termSlider: UISlider!
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var salaryTextField: UITextField!
    @IBOutlet private weak var termTextField: UITextField!
    private var individual: Individual?
    private var organization: Organization?
    private var amount = 0
    private var term = 0
    private var salary = 0
    private let procent = 13
    private var activeTextField: UITextField?
    private var isMoving = false
    // MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavBar(navigationBar)
        NotificationCenter.default.addObserver(self, selector: #selector(NewCreditViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewCreditViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // MARK: - OverrideMethods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        amountSlider.value = Float(amountTextField.text ?? "") ?? 0
        termSlider.value = Float(termTextField.text ?? "") ?? 0
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toConfirmationCreditSegue" else { return }
        guard let destinationVC = segue.destination as? ConfirmationCreditViewController else { return }
        destinationVC.setAmount(Int32(amount * 100))
        destinationVC.setTerm(Int16(term))
        destinationVC.setProcent(Int16(procent))
        destinationVC.setIndividual(individual)
        destinationVC.setOrganization(organization)
    }
    func checkclientSolvency(amount: Int, term: Int, salary: Int) -> Bool {
        let monthlyPay = (amount + amount*(procent/100))/term
        let costs = Double(salary) * 0.4
        if monthlyPay > Int(costs) {
            return false
        }
        return true
    }

    // MARK: - @IBActions
    @IBAction private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if let activeTextField = activeTextField {
                let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY
                let topOfKeyboard = self.view.frame.height - keyboardSize.height
                let inset =  bottomOfTextField - topOfKeyboard
                if inset > 0 && !isMoving {
                    self.view.frame.origin.y -= (inset + 20)
                    isMoving = true
                }
            }
        }
    }
    @IBAction private func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        isMoving = false
    }
    @IBAction private func addCreditButton(_ sender: UIButton) {
        amount = Int.parse(amountTextField.text ?? "") ?? 0
        term = Int.parse(termTextField.text ?? "") ?? 0
        salary = Int.parse(salaryTextField.text ?? "") ?? 0
        if checkCreditDatas(amount, term, salary) {
            if checkclientSolvency(amount: amount, term: term, salary: salary) {
                performSegue(withIdentifier: "toConfirmationCreditSegue", sender: nil)
            } else {
                showAlertMessage(message: "К сожалению, наш Банк не может предоставить Вам кредит на таких условиях. При данном минимальном доходе Вы можете уменьшить сумму кредита либо увеличить срок.")
            }
        }
    }
    @IBAction private func backToCreditsButton(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindFromNewCreditToCreditsSegue", sender: nil)
    }
    @IBAction private func amountSliderAction(_ sender: UISlider) {
        amountTextField.text = String(format: "%g", MyCustomVC.setValueOfSlider(slider: amountSlider, step: 100))
    }
    @IBAction private func termSliderAction(_ sender: UISlider) {
        termTextField.text = String(format: "%g", MyCustomVC.setValueOfSlider(slider: termSlider, step: 6))
    }
    @IBAction private func unwindToNewCreditFromConfirmationCredit(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToNewCreditFromConfirmSegue" else {return}
        guard segue.destination as? ConfirmationCreditViewController != nil else {return}
    }
}
// MARK: - Extensions
extension NewCreditViewController: OrgIndivid {
    func setIndividual(_ individ: Individual?) {
        self.individual = individ
    }
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
}

// MARK: - TextFieldDelegate
extension NewCreditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
      self.activeTextField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
      self.activeTextField = nil
    }
}
