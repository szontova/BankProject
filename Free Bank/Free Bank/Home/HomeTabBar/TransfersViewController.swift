//
//  TransfersViewController.swift
//  Free Bank
//
//  Created by Пользователь on 1.03.21.
//

import UIKit
import CoreData

class TransfersViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var senderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var receiverSegmentedControl: UISegmentedControl!
    
    private var individual: Individual?
    private var organization: Organization?

    override func viewDidLoad() {
        super.viewDidLoad()

        transparentNavBar(navigationBar)
    }
    
    @IBAction func addTransaction(_ sender: UIButton) {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var card: Card?
        var acc: Account?
        let cardRequest = Card.fetchRequest() as NSFetchRequest<Card>
        let accRequest = Account.fetchRequest() as NSFetchRequest<Account>
        do{
            let items = try context.fetch(cardRequest)
            let item = try context.fetch(accRequest)
            card = items.last
            acc = item.last
        } catch{
            print("generation: error in add new branch")
        }
        
        addTransaction(250000, (nil, acc), (card, nil))
    }
}

extension TransfersViewController: OrgIndivid {
    
    func setIndividual(_ individ: Individual?){
        self.individual = individ
    }
    
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
    
}
