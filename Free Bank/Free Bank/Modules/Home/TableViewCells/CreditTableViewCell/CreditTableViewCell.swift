//
//  CreditTableViewCell.swift
//  Free Bank
//
//  Created by Пользователь on 3.03.21.
//

import UIKit

class CreditTableViewCell: UITableViewCell {
    @IBOutlet private weak var creditNumberLabel: UILabel!
    @IBOutlet private weak var mounthlyPayLabel: UILabel!
    @IBOutlet private weak var dateOfRegistrationLabel: UILabel!
    @IBOutlet private weak var myBackgroundView: UIView!
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
    public func configure(_ credit: Credit) {
        self.myBackgroundView.layer.cornerRadius = 5.0
        creditNumberLabel.text = String(credit.id)
        let monthlyPay = MyCustomVC.calculateMonthlyPay(amount: credit.amount, term: credit.term, procent: 13)
        mounthlyPayLabel.text = MyCustomVC.getIntBYRbyString(monthlyPay)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateOfRegistrationLabel.text = dateFormatter.string(for: credit.date) ?? "00.00.0000"
    }
}
