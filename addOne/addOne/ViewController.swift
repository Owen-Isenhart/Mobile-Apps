//
//  ViewController.swift
//  addOne
//
//  Created by Isenhart, Owen E on 12/15/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    var input: String = ""
    var num: Int = 0
    var timer = Timer()
    var time = 60
    var score = 0
    var started = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        scoreLabel.text = "\(score)"
        rndNum()
    }
    @objc func textFieldDidChange(_ textField: UITextField){
        if !started{
            started = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: false)
        }
        guard textField.text?.count == 4 else{
            return
        }
        var temp = Int(numberLabel.text!)!
        if var number = Int(textField.text!){
            if temp + 1111 == number{
                score += 1
                scoreLabel.text = "\(score)"
                textField.text = ""
                rndNum()
            }
            else{
                score -= 1
                scoreLabel.text = "\(score)"
                textField.text = ""
                rndNum()
            }
                
            
        }
        
        
        input = textField.text!
    }
    @objc func timerFunction(_ sender: UIButton!){
        time -= 1
        timeLabel.text = "0:\(time)"
        if time < 10 && time > 0{
            timeLabel.text = "0:0\(time)"
        }
        if time == 0{
            timeLabel.text = "1:00"
            time = 60
            started = false
            var dialogMessage = UIAlertController(title: "Game Over", message: "Score: \(score)", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "Play Again", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
             })
            
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
            score = 0
            scoreLabel.text = "\(score)"
            inputField.text = ""
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: false)
    }
    func rndNum(){
        num = Int.random(in: 1000...9999)
        numberLabel.text = "\(num)"
    }

}

