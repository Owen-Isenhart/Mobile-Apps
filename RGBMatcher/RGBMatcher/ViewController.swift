//
//  ViewController.swift
//  RGBMatcher
//
//  Created by Isenhart, Owen E on 10/17/22.
//

import UIKit

class ViewController: UIViewController {
    var userField = UILabel()
    var matchField = UILabel()
    var timeLabel = UILabel()
    var redLabel = UILabel()
    var greenLabel = UILabel()
    var blueLabel = UILabel()
    var red = UISlider()
    var green = UISlider()
    var blue = UISlider()
    var Rred = Double.random(in: 0...1)
    var Rblue = Double.random(in: 0...1)
    var Rgreen = Double.random(in: 0...1)
    var time = 10
    var difference = 0.0
    var screenW = 0
    var screenH = 0
    var count = 0
    var count2 = 0
    var score = 0
    var changed = false
    var timer = Timer()
    var gameTimer = Timer()
    var progress: Float = 0.5

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let screenB: CGRect = UIScreen.main.bounds
        
        matchField.backgroundColor = UIColor(red: Rred, green: Rgreen, blue: Rblue, alpha: 1)
        
        screenW = Int(screenB.width)
        screenH = Int(screenB.height)
        userField.frame = CGRect(x: 40, y: 80, width: screenW/3, height: screenH/4)
        userField.layer.borderWidth = 3
        userField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        userField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        matchField.frame = CGRect(x: screenW-(screenW/3)-40, y: 80, width: screenW/3, height: screenH/4)
        matchField.layer.borderWidth = 3
        matchField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        redLabel.text = "R"
        redLabel.frame = CGRect(x: (screenW/2)-135, y: (screenH/3)+65, width: 50, height: 50)
        
        red.frame = CGRect(x: (screenW/2)-110, y: (screenH/3)+80, width: 250, height: 20)
        red.isContinuous = true
        red.addTarget(self, action: #selector(timerFunction), for: .valueChanged)
        red.minimumValue = 0
        red.maximumValue = 1
        red.value = 1
        red.largeContentTitle = "R"
        
        greenLabel.text = "G"
        greenLabel.frame = CGRect(x: (screenW/2)-135, y: (screenH/3)+115, width: 50, height: 50)
        
        green.frame = CGRect(x: (screenW/2)-110, y: (screenH/3)+130, width: 250, height: 20)
        green.isContinuous = true
        green.addTarget(self, action: #selector(timerFunction), for: .valueChanged)
        green.minimumValue = 0
        green.maximumValue = 1
        green.value = 1
        
        blueLabel.text = "B"
        blueLabel.frame = CGRect(x: (screenW/2)-135, y: (screenH/3)+165, width: 50, height: 50)
        
        blue.frame = CGRect(x: (screenW/2)-110, y: (screenH/3)+180, width: 250, height: 20)
        blue.isContinuous = true
        blue.addTarget(self, action: #selector(timerFunction), for: .valueChanged)
        blue.minimumValue = 0
        blue.maximumValue = 1
        blue.value = 1
        
        timeLabel.frame = CGRect(x: 40, y: 55, width: 100, height: 15)
        timeLabel.text = "Time: \(time)"

        
        view.addSubview(userField)
        view.addSubview(matchField)
        view.addSubview(red)
        view.addSubview(green)
        view.addSubview(blue)
        view.addSubview(timeLabel)
        view.addSubview(redLabel)
        view.addSubview(greenLabel)
        view.addSubview(blueLabel)
    }
    
    @objc func timerFunction(){
        userField.backgroundColor = UIColor(red: CGFloat(red.value), green: CGFloat(green.value), blue: CGFloat(blue.value), alpha: 1)
        if (count == 0){
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameTimerFunction), userInfo: nil, repeats: true)
        }
        count += 1
        changed = true
    }
    
    @objc func gameTimerFunction(){
        timeLabel.text = "Time: \(time)"
        if changed{
            if (time > 0){
                
                time -= 1
            
            }
            else if count2 == 0{
                displayAlert()
                count2 += 1
            }
        }
        
    }
    
    func displayAlert() {
            // Declare Alert message
        difference = sqrt(pow(Rred - Double(red.value), 2) + pow(Rgreen - Double(green.value), 2) + pow(Rblue - Double(blue.value), 2))
        score = Int(abs((difference-1)*100))
            let dialogMessage = UIAlertController(title: "Game Over!", message: "Score: \(score)", preferredStyle: .alert)
            
            // Create OK button with action handler
            let restart = UIAlertAction(title: "Click to restart", style: .default, handler: { (action) -> Void in
                self.count = 1
                self.time = 10
                self.count2 = 0
                self.red.value = 1
                self.green.value = 1
                self.blue.value = 1
                self.changed = false
                self.Rred = Double.random(in: 0...1)
                self.Rblue = Double.random(in: 0...1)
                self.Rgreen = Double.random(in: 0...1)
                self.matchField.backgroundColor = UIColor(red: self.Rred, green: self.Rgreen, blue: self.Rblue, alpha: 1)

                self.userField.backgroundColor = UIColor(red: CGFloat(self.red.value), green: CGFloat(self.green.value), blue: CGFloat(self.blue.value), alpha: 1)
            })
            
            
            //Add OK and Cancel button to dialog message
            dialogMessage.addAction(restart)
            
            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
            
        }

    func sliderChanged() {
        print("Slider value changed to \(progress)")
    }

}

