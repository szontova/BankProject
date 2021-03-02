//
//  AccountCardsViewController.swift
//  Free Bank
//
//  Created by Пользователь on 2.03.21.
//

import UIKit

class AccountCardsViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var accountBalanceLabel: UILabel!
    @IBOutlet weak var missingCardsLabel: UILabel!
    
    
    private var account: Account?
    private var cards: [Card] = []
    
    func setAccount(_ acc: Account?) {
        self.account = acc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transparentNavBar(navigationBar)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        accountNumberLabel.text = "Cчёт: \(account?.idNumber ?? "")"
        accountBalanceLabel.text = NSString(format: "Баланс: %.2f BYR", account?.balance ?? 0.0) as String
        missingCardsLabel.isHidden = true
        
        updateCards()
        
        if cards.isEmpty { missingCardsLabel.isHidden = false }
    }

    func updateCards() {
        let cardsSet = account?.cards
        cards = Array ( cardsSet as! Set<Card> )
    }
    
    @IBAction func addCardButton(_ sender: UIButton) {
        if let acc = account { addCard(acc) }
        updateCards()
        
        if cards.isEmpty { missingCardsLabel.isHidden = false }
        else { missingCardsLabel.isHidden = true }
    }
}
