//
//  CollectionView.swift
//  Free Bank
//
//  Created by Пользователь on 22.02.21.
//

import Foundation
import UIKit

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let images = Array(imageLinks.keys)
        
        switch indexPath.row % getImages().count{
        case 0:
            openPage(url: imageLinks[images[0]] ?? "")
        case 1:
            openPage(url: imageLinks[images[1]] ?? "")
        case 2:
            openPage(url: imageLinks[images[2]] ?? "")
        default:
            print("The resource can not be found.")
        }
        
        print("you tapped me \(indexPath.row % getImages().count)")
    }
    
    func openPage(url: String){
        if let url = URL(string: url) { UIApplication.shared.open(url, options: [:], completionHandler: nil)}
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getImages().count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.configure(with: UIImage(named: getImages()[indexPath.row % getImages().count])!)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageFloat = (scrollView.contentOffset.x / scrollView.frame.size.width)
        let pageInt = Int(round(pageFloat))
             
        switch pageInt {
        case 0:
            collectionView.scrollToItem(at: [0, getImages().count], at: .left, animated: false)
            
        case getImages().count :
            collectionView.scrollToItem(at: [0, 0], at: .left, animated: false)
            
        default:
            break
        }
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
