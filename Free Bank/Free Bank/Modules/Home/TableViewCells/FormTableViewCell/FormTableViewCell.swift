//
//  FormTableViewCell.swift
//  Free Bank
//
//  Created by Пользователь on 9.03.21.
//

import UIKit

class FormTableViewCell: UITableViewCell {

    static let identifier = "formCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "FormTableViewCell", bundle: nil)
    }
    
    func configure(){
        
    }
    
}
