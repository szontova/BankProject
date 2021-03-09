//
//  CreateSalaryProjectViewController.swift
//  Free Bank
//
//  Created by Пользователь on 9.03.21.
//

import UIKit

class CreateSalaryProjectViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var countsOfWorkersTextField: UITextField!
    @IBOutlet weak var formsTableView: UITableView!
    
    private var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavBar(navigationBar)
        formsTableViewConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFormsTableView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func formsTableViewConfigurations(){
        
        formsTableView.backgroundColor = .clear
        
        //formsTableView.register(FormTableViewCell.nib(), forCellReuseIdentifier: FormTableViewCell.identifier)
        
        formsTableView.delegate = self
        formsTableView.dataSource = self
        
    }
    
    func  updateFormsTableView(){
        if count == 0 {
            formsTableView.isHidden = true
        }
        else {
            formsTableView.isHidden = false
        }
        
        DispatchQueue.main.async {
            self.formsTableView.reloadData()
        }
    }
    
    @IBAction func formsGenerationAction(_ sender: UIButton) {
        count = Int(countsOfWorkersTextField.text ?? "") ?? 0
        updateFormsTableView()
    }
    
    @IBAction func addSalaryProject(_ sender: UIButton) {
    }
    
}

extension CreateSalaryProjectViewController: UITableViewDelegate {}
extension CreateSalaryProjectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = self.formsTableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier) as? FormTableViewCell {
//            cell.selectionStyle = .none
//            cell.configure()
//            return cell
//        }
        return UITableViewCell()
    }
}
