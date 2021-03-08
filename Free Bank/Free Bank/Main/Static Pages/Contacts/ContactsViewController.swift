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
    
    func openSocialMedia(url: String){
        if let url = URL(string: url) { UIApplication.shared.open(url, options: [:], completionHandler: nil)}
    }
    
    @IBAction func callLeraButton(_ sender: UIButton) {
        Util.callNumber(number: "+375291951959")
    }
    
    @IBAction func facebookLeraButton(_ sender: UIButton) {
        openSocialMedia(url: "https://www.facebook.com/lera1605")
    }
    
    @IBAction func vkLeraButton(_ sender: UIButton) {
        openSocialMedia(url: "https://vk.com/lerachubakova")
    }
    
    @IBAction func instagramLeraButton(_ sender: UIButton) {
        openSocialMedia(url: "https://www.instagram.com/lerachubakova/")
    }
    
    @IBAction func linkedLeraButton(_ sender: UIButton) {
        openSocialMedia(url: "http://linkedin.com/in/lerachubakova")
    }
    
    @IBAction func telegramLeraButton(_ sender: UIButton) {
        openSocialMedia(url: "https://t.me/lera_chubakova")
    }
    
    @IBAction func skypeLeraButton(_ sender: UIButton) {
        openSocialMedia(url: "https://join.skype.com/invite/mQabsV93UMho")
    }
    
    @IBAction func callSashaButton(_ sender: UIButton) {
        Util.callNumber(number: "+375295721707")
    }
    
    @IBAction func facebookSashaButton(_ sender: UIButton) {
        openSocialMedia(url: "https://www.facebook.com/")
    }
    
    @IBAction func vkSashaButton(_ sender: UIButton) {
        openSocialMedia(url: "https://vk.com/shzontova")
    }
    
    @IBAction func instagramSashaButton(_ sender: UIButton) {
        openSocialMedia(url: "https://www.instagram.com/shzontova/")
    }
    
    @IBAction func githubSashaButton(_ sender: UIButton) {
        openSocialMedia(url: "https://github.com/szontova/BankProject")
    }
    
    @IBAction func telegramSashaButton(_ sender: UIButton) {
        openSocialMedia(url: "https://t.me/shzontova")
    }
    
    @IBAction func skypeSashaButton(_ sender: UIButton) {
        openSocialMedia(url: "https://join.skype.com/invite/fZdS99SiOzGz")
    }
    
}
