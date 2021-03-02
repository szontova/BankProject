//
//  NewCreditViewController.swift
//  Free Bank
//
//  Created by Sasha Zontova on 3/2/21.
//

import UIKit

class NewCreditViewController: UIViewController {

    @IBOutlet weak var amountSlider: UISlider!
    @IBOutlet weak var termSlider: UISlider!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var termTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(Int.parse("6 months") ?? 0)
    }
    
    func setValueOfSlider(slider: UISlider, step: Float) -> Float{
        let value = round(slider.value/step) * step
        return value
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        amountSlider.value = Float(amountTextField.text ?? "") ?? 0
        termSlider.value = Float(termTextField.text ?? "") ?? 0
    }
    
    @IBAction func addCreditButton(_ sender: UIButton) {
        
    }
    
    @IBAction func amountSliderAction(_ sender: UISlider) {
        amountTextField.text = String(format: "%g", setValueOfSlider(slider: amountSlider, step: 1))
    }
    
    @IBAction func termSliderAction(_ sender: UISlider) {
        termTextField.text = String(format: "%g", setValueOfSlider(slider: termSlider, step: 1))
    }
    
}

extension Int {
    static func parse(_ string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}

