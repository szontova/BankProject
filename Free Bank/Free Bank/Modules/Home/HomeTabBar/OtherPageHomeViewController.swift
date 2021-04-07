//
//  OtherPageHomeViewController.swift
//  Free Bank
//
//  Created by Пользователь on 27.02.21.
//

import UIKit

class OtherPageHomeViewController: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var loginLabel: UILabel!
    @IBOutlet private weak var createSPButton: UIButton!
    @IBOutlet private weak var changeSPButton: UIButton!
    @IBOutlet private weak var paySPButton: UIButton!
    private var individual: Individual?
    private var organization: Organization?
    // MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavBar(navigationBar)
    }
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = individual?.fullName ?? organization?.name
        loginLabel.text = individual?.login ?? organization?.prn
    }
    // MARK: - @IBActions
    @IBAction private func createSPAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toCreateSPSegue", sender: nil)
    }
    @IBAction private func changeSPAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toChangeSPSegue", sender: nil)
    }
    @IBAction private func paySPAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toPaySPSegue", sender: nil)
    }
    @IBAction private func unwindToOtherVCFromCreateSPVC(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToOtherFromCreateSPSegue" else {return}
        guard segue.destination as? CreateSalaryProjectViewController != nil else {return}
    }
    @IBAction private func unwindToOtherVCFromChangeSPVC(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToOtherFromChangeSPSegue" else {return}
        guard segue.destination as? ChangeSalaryProjectViewController != nil else {return}
    }
    @IBAction private func unwindToOtherVCFromPaySPVC(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToOtherFromPaySPSegue" else {return}
        guard segue.destination as? PaySalaryProjectViewController != nil else {return}
    }
}
// MARK: - Extensions
extension OtherPageHomeViewController: OrgIndivid {
    func setIndividual(_ individ: Individual?) {
        self.individual = individ
    }
    func setOrganization (_ org: Organization?) {
        self.organization = org
    }
}
