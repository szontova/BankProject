//
//  ContactsViewController.swift
//  Free Bank
//
//  Created by Пользователь on 25.02.21.
//

import UIKit

class ContactsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction private func callLeraButton(_ sender: UIButton) {
        MyCustomVC.callNumber(number: "+375291951959")
    }
    @IBAction private func facebookLeraButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://www.facebook.com/lera1605")
    }
    @IBAction private func vkLeraButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://vk.com/lerachubakova")
    }
    @IBAction private func instagramLeraButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://www.instagram.com/lerachubakova/")
    }
    @IBAction private func linkedLeraButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "http://linkedin.com/in/lerachubakova")
    }
    @IBAction private func telegramLeraButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://t.me/lera_chubakova")
    }
    @IBAction private func skypeLeraButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://join.skype.com/invite/mQabsV93UMho")
    }
    @IBAction private func callSashaButton(_ sender: UIButton) {
        MyCustomVC.callNumber(number: "+375295721707")
    }
    @IBAction private func facebookSashaButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://www.facebook.com/")
    }
    @IBAction private func vkSashaButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://vk.com/shzontova")
    }
    @IBAction private func instagramSashaButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://www.instagram.com/shzontova/")
    }
    @IBAction private func githubSashaButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://github.com/szontova/BankProject")
    }
    @IBAction private func telegramSashaButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://t.me/shzontova")
    }
    @IBAction private func skypeSashaButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://join.skype.com/invite/fZdS99SiOzGz")
    }
}
