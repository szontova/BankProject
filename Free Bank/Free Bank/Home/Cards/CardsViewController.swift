//
//  CardsViewController.swift
//  Free Bank
//
//  Created by Пользователь on 2.03.21.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var accountBalanceLabel: UILabel!
    @IBOutlet weak var missingCardsLabel: UILabel!
    @IBOutlet weak var cardsTableView: UITableView!
    
    
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
        cardsTableView.isHidden = true
        
        updateCards()
             
        if cards.isEmpty { missingCardsLabel.isHidden = false }
        else { cardsTableView.isHidden = false }
        cardsTableViewConfigurations()
    }

    func updateCards() {
        let cardsSet = account?.cards
        cards = Array ( cardsSet as! Set<Card> )
        cards.sort(){
            return $0.idNumber > $1.idNumber
        }
    }
    
    
    func cardsTableViewConfigurations(){
        
        cardsTableView.backgroundColor = .clear
        
        cardsTableView.register(CardTableViewCell.nib(), forCellReuseIdentifier: CardTableViewCell.identifier)
        
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        
    }
    
    @IBAction func addCardButton(_ sender: UIButton) {
        
        if cards.count < 5 {
            if let acc = account {
                addCardForSimpleAccount(acc)
            }
        } else {
            showAlertError(message: "На один счёт не может быть зарегистрировано более 5 карточек")
        }
        
        updateCards()
        
        if cards.isEmpty {
            missingCardsLabel.isHidden = false
            cardsTableView.isHidden = true
        }
        else {
            missingCardsLabel.isHidden = true
            cardsTableView.isHidden = false
        }
        
        DispatchQueue.main.async {
            self.cardsTableView.reloadData()
        }
    }
}

extension CardsViewController: UITableViewDelegate {}

extension CardsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.cardsTableView.dequeueReusableCell(withIdentifier: CardTableViewCell.identifier) as? CardTableViewCell {
            cell.configure(with: cards[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

}
