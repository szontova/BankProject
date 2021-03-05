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

class UISwitchCustom: UISwitch {
    @IBInspectable var OffTint: UIColor? {
        didSet {
            self.tintColor = OffTint
            self.layer.cornerRadius = self.frame.height / 2.0
            self.backgroundColor = OffTint
        }
    }
}
