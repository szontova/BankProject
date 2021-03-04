//
//  LinkFunctions.swift
//  Free Bank
//
//  Created by Sasha Zontova on 2/26/21.
//

import Foundation
import UIKit


extension UIViewController{
    func callNumber(number: String) {
        if let url: NSURL = URL(string: "TEL://" + number) as NSURL?  { UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)}
    }
    
    func openLink(url: String){
        if let url = URL(string: url) { UIApplication.shared.open(url, options: [:], completionHandler: nil)}
    }
}

public class Util {
   static func calculateMonthlyPay(amount: Int32, term: Int16, procent: Int16) -> Int{
        let monthlyPay = (Float(amount) + (Float(amount) * Float(procent)/100))/Float(term)
        return Int(monthlyPay)
    }
}
