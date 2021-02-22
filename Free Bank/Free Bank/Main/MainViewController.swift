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
    
    private let images = ["cards", "bank", "successfulPeople"]
    
    func getImages() -> [String] {
        return images
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
                
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

    @IBAction func moveToSignInButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignInSegue", sender: nil)
    }
    
    @IBAction func moveToExchangeRateButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toExchangeRateSegue", sender: nil)
    }
    
    @IBAction func unwindToMainVCFromExchangeRateTVC(segue: UIStoryboardSegue){
        guard segue.identifier == "unwindToMainFromExRateSegue" else {return}
        guard let _ = segue.destination as? ExchangeRateTableViewController else {return}
    }
    
    @IBAction func unwindToMainVCFromSignInVC (segue: UIStoryboardSegue){
        guard segue.identifier == "unwindToMainVCSegue" else {return}
        guard let _ = segue.destination as? SignInViewController else {return}
    }
}
