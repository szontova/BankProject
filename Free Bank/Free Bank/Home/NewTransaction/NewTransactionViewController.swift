//
//  NewTransactionViewController.swift
//  Free Bank
//
//  Created by Пользователь on 8.03.21.
//

import UIKit

class NewTransactionViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var accountView: UIView!
    
    @IBOutlet weak var senderCardNumberTextField: UITextField!
    @IBOutlet weak var senderCardValidity: UITextField!
    @IBOutlet weak var senderCardCVV: UITextField!
    
    @IBOutlet weak var senderAccountPickerView: UIPickerView!
    
    @IBOutlet weak var receiverTextField: UITextField!
    
    private var individual: Individual?
    private var organization: Organization?
    private var senderType: (Bool, Bool) = (false,false)
    private var receiverType: (Bool, Bool) = (false,false)
    
    private var accounts: [Account] = []
    
    func setSender( card: Bool,  acc: Bool){
        self.senderType = (card, acc)
    }
    
    func setReceiver( card: Bool,  acc: Bool){
        self.receiverType = (card, acc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transparentNavBar(navigationBar)
        senderAccountPickerViewConfigurations()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toConfirmationTransactionSegue" else { return }
        guard let _ = segue.destination as? ConfirmationTransactionViewController else { return }
//        destinationVC.setSender(card: <#T##Card?#>, acc: <#T##Account?#>)
//        destinationVC.setReceiver(card: <#T##Card?#>, acc: <#T##Account?#>)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //print("\(individual) \(organization) \(senderType) \(receiverType)")
        if senderType.1 {
            cardView.isHidden = true
            accountView.isHidden = false
            updateAccounts()
            senderAccountPickerViewConfigurations()
        } else {
            cardView.isHidden = false
            accountView.isHidden = true
        }
        
        if receiverType.0 {
            receiverTextField.placeholder = "Введите номер карты"
        } else {
            receiverTextField.placeholder = "Введите номер счёта"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func senderAccountPickerViewConfigurations(){
        
        senderAccountPickerView.delegate = self
        senderAccountPickerView.dataSource = self
    }
    
    
    func updateAccounts(){
        let accs = individual?.accounts ?? organization?.accounts
        accounts = Array ( accs as! Set<Account> )
       
        accounts.sort(){
            return $0.idNumber! < $1.idNumber!
        }
        
       accounts = accounts.filter { (acc) -> Bool in
            if let rev = acc.deposit?.revocable {
                return rev
            }
            return true
        }
        print(accounts)
    }
    
    @IBAction func unwindToNewTransactionFromConfirmationTransaction(segue: UIStoryboardSegue){
        guard segue.identifier == "unwindToNewTransactionFromConfirmSegue" else {return}
        guard let _ = segue.destination as? ConfirmationTransactionViewController else {return}
    }
    
    @IBAction func continueTransactionButton(_ sender: UIButton) {
        var result = false
        if senderType.0 {
            result = findCard(by: senderCardNumberTextField.text!) != nil ? true : false
            print(result)
        }
//        if senderType.1 {
//           // result = findAccount(by: senderAccountTextField.text!) != nil ? true : false
//            print(result)
//        }
        if result {
            performSegue(withIdentifier: "toConfirmationTransactionSegue", sender: nil)
        } else {showAlertError(message: "Неверно введены данные отправителя.")}
    }
}

extension NewTransactionViewController: OrgIndivid{
    func setIndividual(_ individ: Individual?) {
        self.individual = individ
    }
    
    func setOrganization(_ org: Organization?) {
        self.organization = org
    }
}

extension NewTransactionViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension NewTransactionViewController: UIPickerViewDelegate {}
extension NewTransactionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accounts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        //label.backgroundColor = UIColor.init(red: 181/255, green: 150/255, blue: 142/255, alpha: 1.0)
        label.backgroundColor = UIColor.init(red: 96/255, green: 3/255, blue: 0/255, alpha: 1.0)
        label.textColor = UIColor.white
        label.textAlignment = .center
        //label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        
        label.layer.frame = CGRect(x: 0,y: 0, width: pickerView.frame.width - 20, height: 26 )
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        
        label.text = accounts[row].idNumber
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 27.5
    }
}
