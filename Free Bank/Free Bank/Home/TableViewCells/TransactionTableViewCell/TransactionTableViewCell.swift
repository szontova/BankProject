//
//  TransactionTableViewCell.swift
//  Free Bank
//
//  Created by Пользователь on 8.03.21.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

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
    public func configure(){
        
    }
    
}
