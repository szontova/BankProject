//
//  MainViewController.swift
//  Free Bank
//
//  Created by Пользователь on 3.02.21.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewFofCollectionView: UIView!
    let imageLinks: [String: String] = ["cards": "https://myfin.by/cards", "bank": "https://www.nbrb.by", "worldNews": "https://myfin.by/stati"]
    func getImages() -> [String] {
        return Array(imageLinks.keys)
    }
    // MARK: - LifeCycleMethods
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
    // MARK: - OurMethods
    func startCollectionViewTimer() {
        _ = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.scrollCollectionViewAutomatically), userInfo: nil, repeats: true)
    }
    // MARK: - @IBActions
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
        performSegue(withIdentifier: "toBankInfoSegue", sender: nil)
    }
    @IBAction func moveToAddressesButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toAddressesSegue", sender: nil)
    }
    @IBAction func scrollCollectionViewAutomatically() {
        let pageInt = Int(round(collectionView.contentOffset.x / collectionView.frame.size.width))
        if pageInt == getImages().count {
            collectionView.scrollToItem(at: [0, 0], at: .left, animated: false)
            if getImages().count > 1 {
                collectionView.scrollToItem(at: [0, 1], at: .left, animated: true)
            }
        } else {
            collectionView.scrollToItem(at: [0, pageInt + 1], at: .left, animated: true)
        }
    }
    // MARK: - unwind @IBActions
    @IBAction func unwindToMainVCFromSignInVC (segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToMainVCSegue" else {return}
        guard segue.destination as? SignInViewController != nil else {return}
    }
    @IBAction func unwindToMainVCFromExchangeRateTVC(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToMainFromExRateSegue" else {return}
        guard segue.destination as? ExchangeRateTableViewController != nil else {return}
    }
    @IBAction func unwindToMainVCFromContactsVC(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToMainFromContactsSegue" else {return}
        guard segue.destination as? ContactsViewController != nil else {return}
    }
    @IBAction func unwindToMainVCFromBankInfoVC(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToMainFromBankInfoSegue" else {return}
        guard segue.destination as? BankInfoViewController != nil else {return}
    }
    @IBAction func unwindToMainVCFromAddressesTVC(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToMainFromAddressesSegue" else {return}
        guard segue.destination as? AddressesTableViewController != nil else {return}
    }
}
