//
//  BankInfoViewController.swift
//  Free Bank
//
//  Created by Пользователь on 25.02.21.
//

import UIKit
import MessageUI
import CoreData

class BankInfoViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var prnLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var shortNumberButton: UIButton!
    @IBOutlet weak var fullNumberButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!

    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

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
        }
        catch{ print("getBank: error with data")}
        return nil
    }
    
    
    func customStyleButton(_ button: UIButton, _ title: String?){
        button.setTitle(title, for: .normal)
        let attrs : [NSAttributedString.Key: Any] = [ .underlineStyle : 1]
        let attributedString = NSAttributedString(string: title ?? "", attributes: attrs)
        button.setAttributedTitle( attributedString, for: .normal)
        
    }
    
    
    func configureLabelsAndButtons(_ freeBank: Bank?){
        if let fb = freeBank {
            nameLabel.text = fb.name
            prnLabel.text = fb.prn
            addressLabel.text = fb.address
            customStyleButton(shortNumberButton, fb.shortNumber)
            customStyleButton(fullNumberButton, fb.fullNumber)
            customStyleButton(emailButton, fb.email)
        }
    }
        
    @IBAction func shortCallButton(_ sender: UIButton) {
        Util.callNumber(number: shortNumberButton.currentTitle!)
    }
    
    @IBAction func fullCallButton(_ sender: UIButton) {
        Util.callNumber(number: fullNumberButton.currentTitle!)
    }
    
    @IBAction func sendMailButton(_ sender: UIButton) {
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

extension BankInfoViewController: MFMailComposeViewControllerDelegate{
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
                dismiss(animated: true)
            }
}
