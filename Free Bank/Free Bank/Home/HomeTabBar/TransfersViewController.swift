//
//  TransfersViewController.swift
//  Free Bank
//
//  Created by Пользователь on 1.03.21.
//

import UIKit
import CoreData

class TransfersViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var senderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var receiverSegmentedControl: UISegmentedControl!
    @IBOutlet weak var accountsPickerView: UIPickerView!
    @IBOutlet weak var missingTransfersLabel: UILabel!
    
    private var individual: Individual?
    private var organization: Organization?

    private var accounts: [Account] = []
    private var transfers: [Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        transparentNavBar(navigationBar)
        accountsPickerViewConfigurations()
    }
    
    func accountsPickerViewConfigurations(){
        
        accountsPickerView.delegate = self
        accountsPickerView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateAccounts()
    }
    
    func updateAccounts(){
        let accs = individual?.accounts ?? organization?.accounts
        accounts = Array ( accs as! Set<Account> )
       
        accounts.sort(){
            return $0.idNumber! < $1.idNumber!
        }
    }
    
    func updateTransfers(_ account: Account) {
        transfers = Array ( account.transactions as! Set<Transaction> )
       
        transfers.sort(){
            return $0.date! < $1.date!
        }
    }
    
    func  updateTransfersTableView(){
        if transfers.isEmpty {
            missingTransfersLabel.isHidden = false
        }
        else {
            missingTransfersLabel.isHidden = true
        }
    }
    
    @IBAction func addTransaction(_ sender: UIButton) {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var card: Card?
        var acc: Account?
        let cardRequest = Card.fetchRequest() as NSFetchRequest<Card>
        let accRequest = Account.fetchRequest() as NSFetchRequest<Account>
        do{
            let items = try context.fetch(cardRequest)
            let item = try context.fetch(accRequest)
            card = items.first
            acc = item.last
        } catch{
            print("generation: error in add new branch")
        }
        
        addTransaction(40000, (card, nil), (nil, acc))
    }
}

extension TransfersViewController: OrgIndivid {
    
    func setIndividual(_ individ: Individual?){
        self.individual = individ
    }
    
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
    
}

extension TransfersViewController: UIPickerViewDelegate{}
extension TransfersViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accounts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.backgroundColor = UIColor.init(red: 181/255, green: 150/255, blue: 142/255, alpha: 1.0)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        
        label.layer.frame = CGRect(x: 0,y: 0, width: pickerView.frame.width - 20, height: 24 )
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        
        label.text = accounts[row].idNumber
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 27.5
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateTransfers(accounts[row])
        updateTransfersTableView()
    }
}
