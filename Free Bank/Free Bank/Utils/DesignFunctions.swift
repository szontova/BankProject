//
//  DesignFunctions.swift
//  Free Bank
//
//  Created by Пользователь on 1.03.21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func transparentNavBar ( _ navigationBar: UINavigationBar ){
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
    
}
