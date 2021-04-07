//
//  TransactionTableViewCell.swift
//  Free Bank
//
//  Created by Пользователь on 8.03.21.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak private var idLabel: UILabel!
    @IBOutlet weak private var senderLabel: UILabel!
    @IBOutlet weak private var receiverLabel: UILabel!
    @IBOutlet weak private var amountLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    static let identifier = "transactionCell"
    static func nib() -> UINib {
        return UINib(nibName: "TransactionTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure() {}
    public func configure(_ transaction: Transaction) {
        idLabel.text = String(transaction.id)
        if let sendString = transaction.sender {
            if let sender = Int(sendString) {
                senderLabel.text = "Карта: \(sender)"
            } else {
                senderLabel.text = "Счёт: \(sendString)"
            }
        }
        if let recString = transaction.receiver {
            if let receiver = Int(recString) {
                receiverLabel.text = "Карта: \(receiver)"
            } else {
                receiverLabel.text = "Счёт: \(recString)"
            }
        }
        amountLabel.text = MyCustomVC.getIntBYRbyString(transaction.amount)
        dateLabel.text = MyCustomVC.getddMMyyyyDateString(transaction.date!)
    }
}
