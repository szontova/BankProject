//
//  CardTableViewCell.swift
//  Free Bank
//
//  Created by Пользователь on 2.03.21.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet private weak var myBackgroundView: UIView!
    @IBOutlet private weak var cardNumberLabel: UILabel!
    @IBOutlet private weak var validDateLabel: UILabel!
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
    func configure(with card: Card) {
        self.myBackgroundView.layer.cornerRadius = 5.0
        cardNumberLabel.text = formatIntByBlocks(card.id)
        validDateLabel.text = card.validity
    }
    func formatIntByBlocks(_ number: Int64) -> String {
        var res = ""
        let numString = String(number)
        for item in 0...numString.count / 4 - 1 {
            res.insert(contentsOf: numString.dropLast(item * 4).suffix(4) + " ", at: res.startIndex)
        }
        return res
    }
}
