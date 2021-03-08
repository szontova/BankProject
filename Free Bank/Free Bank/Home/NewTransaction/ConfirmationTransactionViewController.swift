//
//  ConfirmationTransactionViewController.swift
//  Free Bank
//
//  Created by Пользователь on 8.03.21.
//

import UIKit

class ConfirmationTransactionViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    private var senderType: (Card?, Account?)
    private var receiverType: (Card?, Account?)
    
    func setSender( card: Card?,  acc: Account?){
        self.senderType = (card, acc)
    }

    func setReceiver( card: Card?,  acc: Account?){
        self.receiverType = (card, acc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavBar(navigationBar)
    }
    
}
