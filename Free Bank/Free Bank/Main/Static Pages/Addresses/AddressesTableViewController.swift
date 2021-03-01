//
//  AddressesTableViewController.swift
//  Free Bank
//
//  Created by Пользователь on 27.02.21.
//

import UIKit
import CoreData

private let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class AddressesTableViewController: UITableViewController {
    
    var branches = [Branch]()
    var atms = [ATM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundView = UIImageView(image: UIImage(named: "mainBackground"))
        
        let branchesRequest = Branch.fetchRequest() as NSFetchRequest<Branch>
        let atmsRequest = ATM.fetchRequest() as NSFetchRequest<ATM>
        
        do {
            branches = try context.fetch(branchesRequest)
            atms = try context.fetch(atmsRequest)
            
            print(branches.count)
            print(atms.count)
        } catch {
            print("AddressesTableViewController: Error in get addresses.")
        }
    }
   
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        label.text =  section == 0 ? "Отделы" : "Банкоматы"
        return label
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return branches.count
        }
        return atms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "address", for: indexPath)
        cell.textLabel?.text = indexPath.section == 0 ? branches[indexPath.row].address : atms[indexPath.row].address
        return cell
    }
    
    

}
