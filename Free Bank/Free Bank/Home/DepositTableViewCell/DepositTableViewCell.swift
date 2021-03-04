//
//  DepositTableViewCell.swift
//  Free Bank
//
//  Created by Пользователь on 4.03.21.
//

import UIKit

class DepositTableViewCell: UITableViewCell {

    static let identifier = "depositCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DepositTableViewCell", bundle: nil)
    }
    
    public func configure() {
    }
    
    public func configure(_ deposit: Deposit) {
    
    }
}
