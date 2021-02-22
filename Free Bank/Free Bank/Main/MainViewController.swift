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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
                
        collectionView.delegate = self
        collectionView.dataSource = self
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

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //go to//
        print("you tapped me \(indexPath.row)")
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.configure(with: UIImage(named: images[indexPath.row])!)
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = viewFofCollectionView.bounds.width
        let height = viewFofCollectionView.bounds.height
        
        if height > width {
            return CGSize(width: width - 10 , height: width - 10)
        } else {
            return CGSize(width: height - 10 , height: height - 10)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        let width = viewFofCollectionView.bounds.width
        let height = viewFofCollectionView.bounds.height
        
        if height < width {
            return (width - height + 10)
        }
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var indent: CGFloat = 5.0
        
        let width = viewFofCollectionView.bounds.width
        let height = viewFofCollectionView.bounds.height
        
        if height < width {
            indent = (width - height) / 2 + 5
        }
        return UIEdgeInsets(top: 0, left: indent, bottom: 0, right: indent)
    }
    
    
}
