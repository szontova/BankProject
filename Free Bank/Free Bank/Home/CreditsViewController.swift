//
//  CreditsViewController.swift
//  Free Bank
//
//  Created by Пользователь on 1.03.21.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    private var individual: Individual?
    private var organization: Organization?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transparentNavBar(navigationBar)
    }
    
    @IBAction func unwindToCreditsVCFromNewCreditVC(segue:UIStoryboardSegue){
        guard segue.identifier == "unwindToCreditsFromNewCreditSegue" else {return}
        guard let _ = segue.destination as? NewCreditViewController else {return}
    }
    
    @IBAction func addCredit(_ sender: UIButton) {
        performSegue(withIdentifier: "toNewCreditSegue", sender: nil)
    }
    
}

extension CreditsViewController: OrgIndivid {
    
    func setIndividual(_ individ: Individual?){
        self.individual = individ
    }
    
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
}
