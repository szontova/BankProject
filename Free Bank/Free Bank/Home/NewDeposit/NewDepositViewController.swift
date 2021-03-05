//
//  NewDepositViewController.swift
//  Free Bank
//
//  Created by Пользователь on 5.03.21.
//

import UIKit

class NewDepositViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transparentNavBar(navigationBar)
        // Do any additional setup after loading the view.
    }

    @IBAction func unwindToNewDepositFromConfirmationDeposit(segue: UIStoryboardSegue){
        guard segue.identifier == "unwindToNewDepositFromConfirmSegue" else {return}
        guard let _ = segue.destination as? ConfirmationDepositViewController else {return}
    }
    
    @IBAction func addDepositButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toConfirmationDepositSegue", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
