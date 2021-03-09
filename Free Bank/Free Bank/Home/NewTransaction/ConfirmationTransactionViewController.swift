//
//  ConfirmationTransactionViewController.swift
//  Free Bank
//
//  Created by Пользователь on 8.03.21.
//

import UIKit

class ConfirmationTransactionViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var receiverLabel: UILabel!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var commissionLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var titleSenderLabel: UILabel!
    @IBOutlet weak var titleReceiverLabel: UILabel!
    
    private var senderType: (Card?, Account?)
    private var receiverType: (Card?, Account?)
    
    func setSender( card: Card?,  acc: Account?){
        self.senderType = (card, acc)
    }

    func setReceiver( card: Card?,  acc: Account?){
        self.receiverType = (card, acc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavBar(navigationBar)
        if senderType.0 != nil {
            titleSenderLabel.text = "Номер карты:"
            senderLabel.text = String(senderType.0!.idNumber)
        }else if senderType.1 != nil { senderLabel.text = senderType.1?.idNumber }
        
        if receiverType.0 != nil {
            titleReceiverLabel.text = "Номер карты получателя:"
            receiverLabel.text = String(receiverType.0!.idNumber)
        } else if receiverType.1 != nil { receiverLabel.text = receiverType.1?.idNumber }
        else {
            receiverLabel.text = "Счёт вне банка"
        }

    }
    @IBAction func confirmTransaction(_ sender: UIButton) {
        
    }
    
}
