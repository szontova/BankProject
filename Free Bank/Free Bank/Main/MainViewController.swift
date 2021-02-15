//
//  MainViewController.swift
//  Free Bank
//
//  Created by Пользователь on 3.02.21.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //print("MainViewController: it works")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func moveToSignInButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignInSegue", sender: nil)
    }
    
    @IBAction func moveToExchangeRateButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toExchangeRateSegue", sender: nil)
    }
    
    
    @IBAction func unwindToMainVCFromExchangeRateTVC(segue: UIStoryboardSegue){
        guard segue.identifier == "unwindToMainFromExRateSegue" else {return}
        print(segue.destination)
        guard let _ = segue.destination as? ExchangeRateTableViewController else {return}
    }
    
    @IBAction func unwindToMainVCFromSignInVC (segue: UIStoryboardSegue){
        guard segue.identifier == "unwindToMainVCSegue" else {return}
        guard let _ = segue.destination as? SignInViewController else {return}
    }
}
