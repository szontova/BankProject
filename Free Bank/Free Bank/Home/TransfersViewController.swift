//
//  TransfersViewController.swift
//  Free Bank
//
//  Created by Пользователь on 1.03.21.
//

import UIKit

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
