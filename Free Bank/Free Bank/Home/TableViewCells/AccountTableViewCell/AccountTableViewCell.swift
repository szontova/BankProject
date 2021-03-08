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
    
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var toUpButton: UIButton!
    @IBOutlet weak var deactivationButton: UIButton!
    @IBOutlet weak var moreImageView: UIImageView!
    
    
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
        
        switch Util.getAccCategory(account){
        case "C":
            deactivationButton.isHidden = true
        case "D":
            buttonsStackView.isHidden = true
        case "S":
            buttonsStackView.isHidden = false
            deactivationButton.isHidden = false
        default: break
        }
            
        self.myBackgroundView.layer.cornerRadius = 5.0
        
        self.idNumberLabel.text = account.idNumber
   
        self.balanceLabel.text = Util.getIntBYRbyString(account.balance)
    }
    
    @IBAction func topUpAccBalance(_ sender: UIButton) {
        print("Yes")
    }
    
    @IBAction func deactivationAcc(_ sender: UIButton) {
        print("No")
    }
    
}
