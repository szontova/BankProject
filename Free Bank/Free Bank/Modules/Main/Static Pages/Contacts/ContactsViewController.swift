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
    
    @IBAction func callLeraButton(_ sender: UIButton) {
        MyCustomVC.callNumber(number: "+375291951959")
    }
    
    @IBAction func facebookLeraButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://www.facebook.com/lera1605")
    }
    
    @IBAction func vkLeraButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://vk.com/lerachubakova")
    }
    
    @IBAction func instagramLeraButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://www.instagram.com/lerachubakova/")
    }
    
    @IBAction func linkedLeraButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "http://linkedin.com/in/lerachubakova")
    }
    
    @IBAction func telegramLeraButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://t.me/lera_chubakova")
    }
    
    @IBAction func skypeLeraButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://join.skype.com/invite/mQabsV93UMho")
    }
    
    @IBAction func callSashaButton(_ sender: UIButton) {
        MyCustomVC.callNumber(number: "+375295721707")
    }
    
    @IBAction func facebookSashaButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://www.facebook.com/")
    }
    
    @IBAction func vkSashaButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://vk.com/shzontova")
    }
    
    @IBAction func instagramSashaButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://www.instagram.com/shzontova/")
    }
    
    @IBAction func githubSashaButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://github.com/szontova/BankProject")
    }
    
    @IBAction func telegramSashaButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://t.me/shzontova")
    }
    
    @IBAction func skypeSashaButton(_ sender: UIButton) {
        MyCustomVC.openLink(url: "https://join.skype.com/invite/fZdS99SiOzGz")
    }
    
}
