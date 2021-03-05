//
//  ConfirmationDepositViewController.swift
//  Free Bank
//
//  Created by Пользователь on 5.03.21.
//

import UIKit

class ConfirmationDepositViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transparentNavBar(navigationBar)
     
    }
    
    @IBAction func confirmDepositButton(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToDepositsFromConfirmDepositSegue", sender: nil)
    }
    
}
