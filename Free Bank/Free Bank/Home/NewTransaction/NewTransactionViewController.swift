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
    
    @IBOutlet weak var senderAccountTextField: UITextField!
    
    @IBOutlet weak var receiverTextField: UITextField!
    
    private var individual: Individual?
    private var organization: Organization?
    private var senderType: (Bool, Bool) = (false,false)
    private var receiverType: (Bool, Bool) = (false,false)
    
    func setSender( card: Bool,  acc: Bool){
        self.senderType = (card, acc)
    }
    
    func setReceiver( card: Bool,  acc: Bool){
        self.receiverType = (card, acc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transparentNavBar(navigationBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //print("\(individual) \(organization) \(senderType) \(receiverType)")
        if senderType.1 {
            cardView.isHidden = true
            accountView.isHidden = false
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
    
    @IBAction func continueTransactionButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toConfirmationTransactionSegue", sender: nil)
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
