//
//  AccountTableViewCell.swift
//  Free Bank
//
//  Created by Пользователь on 2.03.21.
//

import UIKit

protocol AccountTableViewCellDelegate: class {
    func addMoney(cell: AccountTableViewCell, didTappedThe button: UIButton?)
    func deactivateAccount(cell: AccountTableViewCell, didTappedThe button: UIButton?)
}
class AccountTableViewCell: UITableViewCell {
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var myBackgroundView: UIView!
    @IBOutlet private weak var buttonsStackView: UIStackView!
    @IBOutlet private weak var toUpButton: UIButton!
    @IBOutlet private weak var deactivationButton: UIButton!
    @IBOutlet private weak var moreImageView: UIImageView!
    weak var cellDelegate: AccountTableViewCellDelegate?
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
    public func configure(with account: Account, count: Int) {
        switch MyCustomVC.getAccCategory(account) {
        case "C":
            deactivationButton.isHidden = true
            buttonsStackView.isHidden = false
        case "D":
            buttonsStackView.isHidden = true
        case "S":
            buttonsStackView.isHidden = false
            deactivationButton.isHidden = false
            if count == 1 {
                deactivationButton.isHidden = true
            }
        default: break
        }
        self.myBackgroundView.layer.cornerRadius = 5.0
        self.idLabel.text = account.id
        self.balanceLabel.text = MyCustomVC.getIntBYRbyString(account.balance)
    }
    @IBAction private func topUpAccBalance(_ sender: UIButton) {
        cellDelegate?.addMoney(cell: self, didTappedThe: sender)
    }
    @IBAction private func deactivationAcc(_ sender: UIButton) {
        cellDelegate?.deactivateAccount(cell: self, didTappedThe: sender)
    }
}
