//
//  CustomUISwitch.swift
//  Free Bank
//
//  Created by Sasha Zontova on 4/5/21.
//

import Foundation
import UIKit

class CustomUISwitch: UISwitch {
    @IBInspectable var OffTint: UIColor? {
        didSet {
            self.tintColor = OffTint
            self.layer.cornerRadius = self.frame.height / 2.0
            self.backgroundColor = OffTint
        }
    }
}
