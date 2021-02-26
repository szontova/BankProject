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
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var shortNumberButton: UIButton!
    @IBOutlet weak var fullNumberButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    //prn //account
    
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
        
        let attrs : [NSAttributedString.Key: Any] = [ .underlineStyle : 1]
        let attributedString = NSAttributedString(string: title ?? "", attributes: attrs)
        button.setAttributedTitle( attributedString, for: .normal)
        
    }
    
    
    func configureLabelsAndButtons(_ freeBank: Bank?){
        if let fb = freeBank {
            nameLabel.text = fb.name
            addressLabel.text = fb.address
            customStyleButton(shortNumberButton, fb.shortNumber)
            customStyleButton(fullNumberButton, fb.fullNumber)
            customStyleButton(emailButton, fb.email)
        }
    }
    
    func callNumber(phone: String){
        if let url: NSURL = URL(string: "TEL://" + phone) as NSURL?  { UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)}
    }
        
    @IBAction func shortCallButton(_ sender: UIButton) {
        callNumber(phone: shortNumberButton.currentTitle!)
    }
    
    @IBAction func fullCallButton(_ sender: UIButton) {
        callNumber(phone: fullNumberButton.currentTitle!)
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
