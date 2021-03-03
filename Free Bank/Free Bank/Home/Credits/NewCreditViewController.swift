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
    
    private var amount = 0
    private var term = 0
    private var salary = 0
    
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
        amount = Int.parse(amountTextField.text ?? "") ?? 0
        term = Int.parse(termTextField.text ?? "") ?? 0
        salary = Int.parse(salaryTextField.text ?? "") ?? 0
        if checkCreditDatas(amount, term, salary) {
            showAlertMessageWithSegue(message: "Ваш кредит оформлен", segue: "unwindFromNewCreditToCreditsSegue")
        }
    }
    
    @IBAction func backToCreditsButton(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindFromNewCreditToCreditsSegue", sender: nil)
    }
    
    @IBAction func amountSliderAction(_ sender: UISlider) {
        amountTextField.text = String(format: "%g", setValueOfSlider(slider: amountSlider, step: 100))
    }
    
    @IBAction func termSliderAction(_ sender: UISlider) {
        termTextField.text = String(format: "%g", setValueOfSlider(slider: termSlider, step: 6))
    }
    
}

extension Int {
    static func parse(_ string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}

