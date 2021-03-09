//
//  OtherPageHomeViewController.swift
//  Free Bank
//
//  Created by Пользователь on 27.02.21.
//

import UIKit

class OtherPageHomeViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var createSPButton: UIButton!
    @IBOutlet weak var changeSPButton: UIButton!
    @IBOutlet weak var paySPButton: UIButton!
    
    
    private var individual: Individual?
    private var organization: Organization?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transparentNavBar(navigationBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = individual?.fullName ?? organization?.name
        loginLabel.text = individual?.login ?? organization?.prn
    }
    
    
    @IBAction func unwindToOtherVCFromCreateSPVC(segue:UIStoryboardSegue){
        guard segue.identifier == "unwindToOtherFromCreateSPSegue" else {return}
        guard let _ = segue.destination as? CreateSalaryProjectViewController else {return}
    }
    @IBAction func unwindToOtherVCFromChangeSPVC(segue:UIStoryboardSegue){
        guard segue.identifier == "unwindToOtherFromChangeSPSegue" else {return}
        guard let _ = segue.destination as? ChangeSalaryProjectViewController else {return}
    }
    @IBAction func unwindToOtherVCFromPaySPVC(segue:UIStoryboardSegue){
        guard segue.identifier == "unwindToOtherFromPaySPSegue" else {return}
        guard let _ = segue.destination as? PaySalaryProjectViewController else {return}
    }
    
    
    
    
    @IBAction func createSPAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toCreateSPSegue", sender: nil)
    }
    @IBAction func changeSPAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toChangeSPSegue", sender: nil)
    }
    @IBAction func paySPAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toPaySPSegue", sender: nil)
    }
    
}

extension OtherPageHomeViewController: OrgIndivid {
    
    func setIndividual(_ individ: Individual?){
        self.individual = individ
    }
    
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
}
