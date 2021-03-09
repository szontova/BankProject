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
    private var amount:Int?
    private var commission: Int?
    
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
            balanceLabel.text = Util.getIntBYRbyString((senderType.0?.account!.balance)!)
        }else if senderType.1 != nil {
            senderLabel.text = senderType.1?.idNumber
            balanceLabel.text = Util.getIntBYRbyString((senderType.1?.balance)!)
        }
        
        if receiverType.0 != nil {
            titleReceiverLabel.text = "Номер карты получателя:"
            receiverLabel.text = Util.getIntBYRbyString((receiverType.0!.idNumber))
        } else if receiverType.1 != nil { receiverLabel.text = receiverType.1?.idNumber }
        else {
            receiverLabel.text = "Счёт вне банка"
            commissionLabel.text = Util.getIntBYRbyString(100)
        }
        amount = (Int.parse(amountTextField.text ?? "0") ?? 0) * 100
        commission = Int.parse(commissionLabel.text ?? "0") ?? 0
        totalLabel.text = Util.getIntBYRbyString((amount ?? 0) + (commission ?? 0))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        amount = (Int.parse(amountTextField.text ?? "0") ?? 0) * 100
        commission = Int.parse(commissionLabel.text ?? "0") ?? 0
        totalLabel.text = Util.getIntBYRbyString((amount ?? 0) + (commission ?? 0))
    }
    
    @IBAction func confirmTransaction(_ sender: UIButton) {
        
    }
    
}
