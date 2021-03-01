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
        
        //addBranch(address: "г.Брест, ул.Центральная 9")
        //addATM(address: "г.Брест, ул.Ленина 19")
        
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
    
    func addBranch(address: String){
        let newBranch = Branch(context: context)
        
        let request = Branch.fetchRequest() as NSFetchRequest<Branch>
        do{
            
            var items = try context.fetch(request)
            items.sort(by: {str1,str2 in return str1.idNumber < str2.idNumber})
            if (items.count == 0){
                newBranch.idNumber = 1
            }
            else{
                let newIdNumber = Int64(items.last!.idNumber) + 1
                newBranch.idNumber = newIdNumber
            }
        } catch{
            print("generation: error in add new branch")
        }
        newBranch.address = address
        
        do {
            context.insert(newBranch)
            try context.save()
        } catch {
            print("addBranch: error in add address")
        }
    }
    
    func addATM(address: String){
        let newATM = ATM(context: context)
        
        let request = ATM.fetchRequest() as NSFetchRequest<ATM>
        do{
            
            var items = try context.fetch(request)
            items.sort(by: {str1,str2 in return str1.idNumber < str2.idNumber})
            if (items.count == 0){
                newATM.idNumber = 1
            }
            else{
                let newIdNumber = Int64(items.last!.idNumber) + 1
                newATM.idNumber = newIdNumber
            }
        } catch{
            print("generation: error in add new ATM")
        }
        newATM.address = address
        
        do {
            context.insert(newATM)
            try context.save()
        } catch {
            print("addATM: error in add address")
        }
    }

}
