//
//  BankInfoViewController.swift
//  Free Bank
//
//  Created by Пользователь on 25.02.21.
//

import CoreData
import MessageUI
import UIKit

class BankInfoViewController: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var prnLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var shortNumberButton: UIButton!
    @IBOutlet private weak var fullNumberButton: UIButton!
    @IBOutlet private weak var emailButton: UIButton!
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabelsAndButtons(getBank())
        // Do any additional setup after loading the view.
    }
    func getBank () -> Bank? {
        let bankRequest = Bank.fetchRequest() as NSFetchRequest<Bank>
        do {
           let bank = try context.fetch(bankRequest)
            if  !bank.isEmpty {
                return bank[0]
            }
        } catch {print("getBank: error with data")}
        return nil
    }
    func customStyleButton(_ button: UIButton, _ title: String?) {
        button.setTitle(title, for: .normal)
        let attrs: [NSAttributedString.Key: Any] = [.underlineStyle: 1]
        let attributedString = NSAttributedString(string: title ?? "", attributes: attrs)
        button.setAttributedTitle( attributedString, for: .normal)
    }
    func configureLabelsAndButtons(_ freeBank: Bank?) {
        if let fb = freeBank {
            nameLabel.text = fb.name
            prnLabel.text = fb.prn
            addressLabel.text = fb.address
            customStyleButton(shortNumberButton, fb.shortNumber)
            customStyleButton(fullNumberButton, fb.fullNumber)
            customStyleButton(emailButton, fb.email)
        }
    }
    // MARK: - @IBActions
    @IBAction private func shortCallButton(_ sender: UIButton) {
        MyCustomVC.callNumber(number: shortNumberButton.currentTitle!)
    }
    @IBAction private func fullCallButton(_ sender: UIButton) {
        MyCustomVC.callNumber(number: fullNumberButton.currentTitle!)
    }
    @IBAction private func sendMailButton(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Поддержка приложения FreeBank")
            mail.setToRecipients([emailButton.currentTitle!])
            mail.setMessageBody("Здравствуйте! Дайте денег, пожалуйста.", isHTML: false)
            present(mail, animated: true)

        } else {
            showAlertError(message: "Ошибка при отправлении письма.")
        }
    }
}

// MARK: - Extensions
extension BankInfoViewController: MFMailComposeViewControllerDelegate {
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
                dismiss(animated: true)
            }
}
