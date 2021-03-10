//
//  PaySalaryProjectViewController.swift
//  Free Bank
//
//  Created by Пользователь on 9.03.21.
//

import UIKit

class PaySalaryProjectViewController: UIViewController {
    @IBOutlet private weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavBar(navigationBar)
    }
    
}
