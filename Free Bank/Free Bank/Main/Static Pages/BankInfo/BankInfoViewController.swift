//
//  BankInfoViewController.swift
//  Free Bank
//
//  Created by Пользователь on 25.02.21.
//

import UIKit
import MessageUI

class BankInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func callNumber(phone: String){
        if let url: NSURL = URL(string: "TEL://" + phone) as NSURL?  { UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)}
    }
        
    @IBAction func shortCallButton(_ sender: UIButton) {
        callNumber(phone: "123")
    }
    @IBAction func fullCallButton(_ sender: UIButton) {
        callNumber(phone: "+375295721707")
    }
    
    @IBAction func sendMailButton(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Поддержка приложения FreeBank")
            mail.setToRecipients(["freebank.by@gmail.com"])
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
