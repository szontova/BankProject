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
    
    private var individual: Individual?
    private var organization: Organization?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = individual?.fullName ?? organization?.name
        loginLabel.text = individual?.login ?? organization?.prn
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
