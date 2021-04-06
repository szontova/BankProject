//
//  IntExtension.swift
//  Free Bank
//
//  Created by Sasha Zontova on 4/5/21.
//

import Foundation
import UIKit

extension Int {
    static func parse(_ string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}
