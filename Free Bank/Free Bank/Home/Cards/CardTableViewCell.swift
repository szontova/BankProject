//
//  CardTableViewCell.swift
//  Free Bank
//
//  Created by Пользователь on 2.03.21.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var myBackgroundView: UIView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var validDateLabel: UILabel!
    
    
    static let identifier = "cardCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CardTableViewCell", bundle: nil)
    }
    
    func configure(with card: Card){
        self.myBackgroundView.layer.cornerRadius = 5.0
        cardNumberLabel.text = String(card.idNumber)
        validDateLabel.text = card.validity
        //print(card.idNumber)
    }
}
