//
//  AccountCardsViewController.swift
//  Free Bank
//
//  Created by Пользователь on 2.03.21.
//

import UIKit

class AccountCardsViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    private var account = Account()
    
    func setAccount(_ acc: Account) {
        self.account = acc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transparentNavBar(navigationBar)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(account.string())
    }

}
