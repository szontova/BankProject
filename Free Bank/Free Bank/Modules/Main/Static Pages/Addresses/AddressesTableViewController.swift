//
//  AddressesTableViewController.swift
//  Free Bank
//
//  Created by Пользователь on 27.02.21.
//

import CoreData
import UIKit

private let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class AddressesTableViewController: UITableViewController {
    var branches = [Branch]()
    var atms = [ATM]()
    let branchesRequest = Branch.fetchRequest() as NSFetchRequest<Branch>
    let atmsRequest = ATM.fetchRequest() as NSFetchRequest<ATM>
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            branches = try context.fetch(branchesRequest)
            atms = try context.fetch(atmsRequest)
            if branches.isEmpty {
                createBranches()
                branches = try context.fetch(branchesRequest)
                branches.sort(by: {str1, str2 in return str1.address! < str2.address!})
            } else {branches.sort(by: {str1, str2 in return str1.address! < str2.address!})}
            if atms.isEmpty {
                createATMs()
                atms = try context.fetch(atmsRequest)
                atms.sort(by: {str1, str2 in return str1.address! < str2.address!})
            } else {atms.sort(by: {str1, str2 in return str1.address! < str2.address!})}
        } catch {
            print("AddressesTableViewController: Error in get addresses.")
        }
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "mainBackground"))
    }
    // MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.init(red: 60/255, green: 22/255, blue: 22/255, alpha: 1.0)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.text = section == 0 ? "Отделы" : "Банкоматы"
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
