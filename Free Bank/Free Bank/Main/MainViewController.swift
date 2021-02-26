//
//  MainViewController.swift
//  Free Bank
//
//  Created by Пользователь on 3.02.21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewFofCollectionView: UIView!
    
    let imageLinks: Dictionary<String, String> = ["cards" : "https://myfin.by/cards", "bank" : "https://www.nbrb.by", "successfulPeople" : "https://myfin.by/stati"]

    func getImages() -> [String] {
        return Array(imageLinks.keys)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
                
        collectionView.delegate = self
        collectionView.dataSource = self
        
        startCollectionViewTimer()
        
        createBank()
        createTemplateIndividuals()
        createTemplateOrganizations()
        
    }
    
    func startCollectionViewTimer() {
        _ = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.scrollCollectionViewAutomatically), userInfo: nil, repeats: true)
    }

    @IBAction func moveToSignInButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignInSegue", sender: nil)
    }
    
    @IBAction func moveToExchangeRateButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toExchangeRateSegue", sender: nil)
    }
    
    @IBAction func moveToContactsButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toContactsSegue", sender: nil)
    }
    
    @IBAction func moveToBankInfoButton(_ sender: UIButton) {
        print("")
        performSegue(withIdentifier: "toBankInfoSegue", sender: nil)
    }
    
    @IBAction func unwindToMainVCFromSignInVC (segue: UIStoryboardSegue){
        guard segue.identifier == "unwindToMainVCSegue" else {return}
        guard let _ = segue.destination as? SignInViewController else {return}
    }
    
    @IBAction func unwindToMainVCFromExchangeRateTVC(segue: UIStoryboardSegue){
        guard segue.identifier == "unwindToMainFromExRateSegue" else {return}
        guard let _ = segue.destination as? ExchangeRateTableViewController else {return}
    }

    @IBAction func unwindToMainVCFromContactsVC(segue: UIStoryboardSegue){
        guard segue.identifier == "unwindToMainFromContactsSegue" else {return}
        guard let _ = segue.destination as? ContactsViewController else {return}
    }
    
    @IBAction func unwindToMainVCFromBankInfoVC(segue: UIStoryboardSegue){
        guard segue.identifier == "unwindToMainFromBankInfoSegue" else {return}
        guard let _ = segue.destination as? BankInfoViewController else {return}
    }
    
    @IBAction func scrollCollectionViewAutomatically(){
        let pageInt = Int(round(collectionView.contentOffset.x / collectionView.frame.size.width))
  
        if pageInt == getImages().count {
            collectionView.scrollToItem(at: [0, 0], at: .left, animated: false)
            if getImages().count > 1 {
                collectionView.scrollToItem(at: [0, 1], at: .left, animated: true)
            }
        }
        else {
            collectionView.scrollToItem(at: [0, pageInt + 1], at: .left, animated: true)
        }
    }
}
