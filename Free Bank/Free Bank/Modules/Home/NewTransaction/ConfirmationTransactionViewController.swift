//
//  ConfirmationTransactionViewController.swift
//  Free Bank
//
//  Created by Пользователь on 8.03.21.
//

import UIKit

class ConfirmationTransactionViewController: UIViewController {

    // MARK: - @IBOutlets
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var senderLabel: UILabel!
    @IBOutlet private weak var receiverLabel: UILabel!
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var commissionLabel: UILabel!
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var titleSenderLabel: UILabel!
    @IBOutlet private weak var titleReceiverLabel: UILabel!
    private var amount: Int?
    private var commission: Int?
    private var total: Int64?
    private var senderType: (Card?, Account?)
    private var receiverType: (Card?, Account?)
    func setSender( card: Card?, acc: Account?) {
        self.senderType = (card, acc)
    }
    func setReceiver( card: Card?, acc: Account?) {
        self.receiverType = (card, acc)
    }
    // MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavBar(navigationBar)
        if senderType.0 != nil {
            titleSenderLabel.text = "Номер карты:"
            senderLabel.text = String(senderType.0!.id)
            balanceLabel.text = MyCustomVC.getIntBYRbyString((senderType.0?.account!.balance)!)
        } else if senderType.1 != nil {
            senderLabel.text = senderType.1?.id
            balanceLabel.text = MyCustomVC.getIntBYRbyString((senderType.1?.balance)!)
        }
        if receiverType.0 != nil {
            titleReceiverLabel.text = "Номер карты получателя:"
            receiverLabel.text = String(receiverType.0!.id)
        } else if receiverType.1 != nil { receiverLabel.text = receiverType.1?.id } else {
            receiverLabel.text = "Счёт вне банка"
            commissionLabel.text = MyCustomVC.getIntBYRbyString(100)
        }
        amount = (Int.parse(amountTextField.text ?? "0") ?? 0) * 100
        commission = Int.parse(commissionLabel.text ?? "0") ?? 0
        totalLabel.text = MyCustomVC.getIntBYRbyString((amount ?? 0) + (commission ?? 0))
    }
    // MARK: - OverrideMethods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        amount = (Int.parse(amountTextField.text ?? "0") ?? 0) * 100
        commission = Int.parse(commissionLabel.text ?? "0") ?? 0
        total = Int64((amount ?? 0) + (commission ?? 0))
        totalLabel.text = MyCustomVC.getIntBYRbyString(total ?? 0)
    }
    // MARK: - @IBActions
    @IBAction private func confirmTransaction(_ sender: UIButton) {
        amount = (Int.parse(amountTextField.text ?? "0") ?? 0) * 100
        commission = Int.parse(commissionLabel.text ?? "0") ?? 0
        total = Int64((amount ?? 0) + (commission ?? 0))
        totalLabel.text = MyCustomVC.getIntBYRbyString(total ?? 0)
        if (amount ?? 0) < 100 || (amount ?? 0) > 250000 {
            showAlertError(message: "Сумма не должна превышать 2500 BYR")
        } else {
            if addTransaction((total ?? 0), senderType, receiverType) {
            performSegue(withIdentifier: "unwindToTransactionsFromConfirmTransactionSegue", sender: nil)
            }
        }
    }
}
