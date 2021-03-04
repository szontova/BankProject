//
//  LinkFunctions.swift
//  Free Bank
//
//  Created by Sasha Zontova on 2/26/21.
//

import Foundation
import UIKit


public class Util {
   static func calculateMonthlyPay(amount: Int32, term: Int16, procent: Int16) -> Int{
        let monthlyPay = (Float(amount) + (Float(amount) * Float(procent)/100))/Float(term)
        return Int(monthlyPay)
    }
    
    static func getDate() -> Date{
        let seconds:TimeInterval = 180.0 * 60.0;
        let date = Date(timeIntervalSinceNow: seconds)
        return date
    }
    
    static func getAccCategory(_ acc: Account) -> Character{
        return acc.idNumber!.dropFirst(16).first!
    }
    
    static func getValidityDate(_ years: Int) -> String{
        let validDate = NSDate(timeInterval: TimeInterval(years * 365 * 24 * 60 * 60) , since: NSDate() as Date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yy"
        return dateFormatter.string(for: validDate) ?? "00/00"
    }
    
    static func getddMMyyyyDateString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(for: date) ?? "00.00.0000"
    }
    
    static func getIntervalDate(_ date: Date, _ years: Float) -> Date {
       return NSDate(timeInterval: TimeInterval(years * 365 * 24 * 60 * 60) , since: date) as Date
    }
    
    static func callNumber(number: String) {
        if let url: NSURL = URL(string: "TEL://" + number) as NSURL?  { UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)}
    }
    
    static func openLink(url: String){
        if let url = URL(string: url) { UIApplication.shared.open(url, options: [:], completionHandler: nil)}
    }
}
