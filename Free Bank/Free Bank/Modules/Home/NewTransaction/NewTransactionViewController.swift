//
//  NewTransactionViewController.swift
//  Free Bank
//
//  Created by Пользователь on 8.03.21.
//

import UIKit

class NewTransactionViewController: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet weak private var navigationBar: UINavigationBar!
    @IBOutlet weak private var cardView: UIView!
    @IBOutlet weak private var accountView: UIView!
    @IBOutlet weak private var senderCardNumberTextField: UITextField!
    @IBOutlet weak private var senderCardValidity: UITextField!
    @IBOutlet weak private var senderCardCVV: UITextField!
    @IBOutlet weak private var senderAccountPickerView: UIPickerView!
    @IBOutlet weak private var receiverTextField: UITextField!
    private var activeTextField: UITextField?
    private var isMoving = false
    private var individual: Individual?
    private var organization: Organization?
    private var senderType: (Bool, Bool) = (false, false)
    private var receiverType: (Bool, Bool) = (false, false)
    private var account: Account?
    private var accounts: [Account] = []
    func setSender( card: Bool, acc: Bool) {
        self.senderType = (card, acc)
    }
    func setReceiver( card: Bool, acc: Bool) {
        self.receiverType = (card, acc)
    }
    // MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavBar(navigationBar)
        senderAccountPickerViewConfigurations()
        NotificationCenter.default.addObserver(self, selector: #selector(NewTransactionViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewTransactionViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        if senderType.1 {
            cardView.isHidden = true
            accountView.isHidden = false
            updateAccounts()
            senderAccountPickerViewConfigurations()
            account = accounts[0]
        } else {
            cardView.isHidden = false
            accountView.isHidden = true
        }
        if receiverType.0 {
            receiverTextField.placeholder = "Введите номер карты"
            receiverTextField.keyboardType = .numberPad
        } else {
            receiverTextField.placeholder = "Введите номер счёта"
        }
    }
    // MARK: - OverrideMethods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toConfirmationTransactionSegue" else { return }
        guard let destinationVC = segue.destination as? ConfirmationTransactionViewController else { return }
        destinationVC.setSender(card: findCard(by: (senderCardNumberTextField.text)!), acc: account)
        destinationVC.setReceiver(card: findCard(by: (receiverTextField.text)!), acc: findAccount(by: (receiverTextField.text)!))
    }
    func senderAccountPickerViewConfigurations() {
        senderAccountPickerView.delegate = self
        senderAccountPickerView.dataSource = self
    }
    func updateAccounts() {
        let accs = individual?.accounts ?? organization?.accounts
        accounts = Array( accs as! Set<Account> )
        accounts.sort {
            return $0.id! < $1.id!
        }
       accounts = accounts.filter { (acc) -> Bool in
            if let rev = acc.deposit?.revocable {
                return rev
            }
            return true
        }
    }
    // MARK: - @IBActions
    @IBAction func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if let activeTextField = activeTextField {
                let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY
                let topOfKeyboard = self.view.frame.height - keyboardSize.height
                let inset =  bottomOfTextField - topOfKeyboard
                if inset > 0 && !isMoving {
                    self.view.frame.origin.y -= (inset + 50)
                    isMoving = true
                }
            }
        }
    }
    @IBAction func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        isMoving = false
    }
    @IBAction func unwindToNewTransactionFromConfirmationTransaction(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToNewTransactionFromConfirmSegue" else {return}
        guard segue.destination as? ConfirmationTransactionViewController != nil else {return}
    }
    @IBAction func continueTransactionButton(_ sender: UIButton) {
        var result = true
        if senderType.0 {
            result = findCard(by: senderCardNumberTextField.text!) != nil ? true : false
            print(result)
            if senderCardNumberTextField.text == "" /*|| senderCardValidity.text == "" || senderCardCVV.text == ""*/ { result = false }
        }
        if receiverTextField.text == "" { result = false }
        if result {
            performSegue(withIdentifier: "toConfirmationTransactionSegue", sender: nil)
        } else {showAlertError(message: "Неверные данные для проведения операции.")}
    }
}
// MARK: - Extensions
extension NewTransactionViewController: OrgIndivid {
    func setIndividual(_ individ: Individual?) {
        self.individual = individ
    }
    func setOrganization(_ org: Organization?) {
        self.organization = org
    }
}
// MARK: TextFieldDelegate
extension NewTransactionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
      self.activeTextField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
      self.activeTextField = nil
    }
}
// MARK: PickerView
extension NewTransactionViewController: UIPickerViewDelegate {}
extension NewTransactionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        account = accounts[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accounts.count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.backgroundColor = UIColor.init(red: 96/255, green: 3/255, blue: 0/255, alpha: 1.0)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.frame = CGRect(x: 0, y: 0, width: pickerView.frame.width - 20, height: 26)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.text = accounts[row].id
        return label
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 27.5
    }
}
