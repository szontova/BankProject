//
//  AccountTableViewCell.swift
//  Free Bank
//
//  Created by Пользователь on 2.03.21.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

   
    @IBOutlet weak var idNumberLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var myBackgroundView: UIView!
    
    static let identifier = "accountCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "AccountTableViewCell", bundle: nil)
    }
    
    public func configure(with account: Account) {
        self.myBackgroundView.layer.cornerRadius = 5.0
        
        self.idNumberLabel.text = account.idNumber
        
        let balance = (Float(account.balance) / 100.00)
        self.balanceLabel.text = NSString(format: "%.2f BYR", balance) as String
    }
}
