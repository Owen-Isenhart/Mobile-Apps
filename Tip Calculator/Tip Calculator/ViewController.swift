//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Isenhart, Owen E on 12/1/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var tip: UISegmentedControl!
    @IBOutlet weak var tipAmnt: UILabel!
    @IBOutlet weak var totalAmnt: UILabel!
    @IBOutlet weak var other: UISlider!
    @IBOutlet weak var resetBtn: UIButton!
    var timer = Timer()
    var bill: Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        input.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        tip.addTarget(self, action: "segmentedControlValueChanged:", for: UIControl.Event.valueChanged)
        other.addTarget(self, action: "sliderChanged:", for: .valueChanged)
        other.isHidden = true
        other.minimumValue = 0
        other.maximumValue = 100
        other.value = 50
        resetBtn.addTarget(self, action: "resetValues:", for: .touchUpInside)
    }
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        calculateTip()
    }
    @objc func sliderChanged(_ sender: UISlider){
        calculateTip()
    }
    @objc func resetValues(_ sender: UIButton){
        bill = 0
        input.text = ""
        tip.selectedSegmentIndex = 0
        tipAmnt.text = ""
        totalAmnt.text = ""
        other.isHidden = true
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let billD = Double(textField.text!){
            bill = billD
        }
        calculateTip()
    }
    func calculateTip(){
        if let billD = Double(input.text!){
            var temp = 0.0
            bill = 0
            var select = tip.selectedSegmentIndex
            if select == 0{
                temp = billD*0.15
            }
            if select == 1{
                temp = billD*0.18
            }
            if select == 2{
                temp = billD*0.2
            }
            if select == 3{
                other.isHidden = false
                temp = billD*(Double(other.value)/100)
            }
            else{
                other.isHidden = true
            }
            if (input.text == ""){
                bill = 0
                temp = 0
            }
            else{
                bill = billD+temp
            }
            tipAmnt.text = String(format: "%.2f", temp)
            totalAmnt.text = String(format: "%.2f", bill)
        }
        
        
    }
    


}

