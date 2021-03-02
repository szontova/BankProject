//
//  NewCreditViewController.swift
//  Free Bank
//
//  Created by Sasha Zontova on 3/2/21.
//

import UIKit

class NewCreditViewController: UIViewController {

    @IBOutlet weak var amountSlider: UISlider!
    @IBOutlet weak var salarySlider: UISlider!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var termTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(Int.parse("6 months") ?? 0)
        
        // Do any additional setup after loading the view.
    }
    
    func setValueOfSlider(slider: UISlider, step: Float) -> Float{
        let value = round(slider.value/step) * step
        return value
    }
    
    @IBAction func addCreditButton(_ sender: UIButton) {
        
    }
    
    @IBAction func amountSliderAction(_ sender: UISlider) {
//        amountLabel.text = String(format: "%g", setValueOfSlider(slider: amountSlider, step: 1))
    }
    
    @IBAction func termSliderAction(_ sender: UISlider) {
//        salaryLabel.text = String(format: "%g", setValueOfSlider(slider: salarySlider, step: 1))
    }
    
}

extension Int {
    static func parse(_ string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}

