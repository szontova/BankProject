//
//  CreditViewController.swift
//  Free Bank
//
//  Created by Пользователь on 4.03.21.
//

import UIKit

class CreditViewController: UIViewController {
    @IBOutlet private weak var navigationBar: UINavigationBar!
    private var credit: Credit?
    
    func setCredit(_ credit: Credit) {
        self.credit = credit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavBar(navigationBar)
        print(credit)
    }
    
}
