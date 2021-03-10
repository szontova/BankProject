//
//  CreateSalaryProjectViewController.swift
//  Free Bank
//
//  Created by Пользователь on 9.03.21.
//

import UIKit

class CreateSalaryProjectViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var countsOfWorkersTextField: UITextField!
    @IBOutlet private weak var formsTableView: UITableView!
    
    private var count = 0
    
    //MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavBar(navigationBar)
        formsTableViewConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFormsTableView()
    }
    
    //MARK: - OverrideMethods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: -
    func formsTableViewConfigurations(){
        
        formsTableView.backgroundColor = .clear
        
        formsTableView.register(FormTableViewCell.nib(), forCellReuseIdentifier: FormTableViewCell.identifier)
        
        formsTableView.delegate = self
        formsTableView.dataSource = self
        
    }
    
    func updateFormsTableView(){
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
    //MARK: - @IBActions
    @IBAction func formsGenerationAction(_ sender: UIButton) {
        count = Int(countsOfWorkersTextField.text ?? "") ?? 0
        updateFormsTableView()
    }
    
    @IBAction func addSalaryProject(_ sender: UIButton) {
    }
    
}

//MARK: - Extensions
extension CreateSalaryProjectViewController: UITableViewDelegate {}
extension CreateSalaryProjectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.formsTableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier) as? FormTableViewCell {
            cell.selectionStyle = .none
            cell.configure()
            return cell
        }
        return UITableViewCell()
    }
}
