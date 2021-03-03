//
//  CreditTableViewCell.swift
//  Free Bank
//
//  Created by Пользователь on 3.03.21.
//

import UIKit

class CreditTableViewCell: UITableViewCell {
    
    @IBOutlet weak var creditNumberLabel: UILabel!
    @IBOutlet weak var mounthlyPayLabel: UILabel!
    @IBOutlet weak var dateOfRegistrationLabel: UILabel!
    @IBOutlet weak var myBackgroundView: UIView!
    

    static let identifier = "creditCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CreditTableViewCell", bundle: nil)
    }
    
    public func configure() {
        self.myBackgroundView.layer.cornerRadius = 5.0
    }
    
}
