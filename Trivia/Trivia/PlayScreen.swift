//
//  PlayScreen.swift
//  Trivia
//
//  Created by Isenhart, Owen E on 2/16/23.
//

import UIKit
class PlayScreen : UIViewController{
    var score = 0
    var timer = Timer()
    var numQuestions: Int = 1
    var increment: Double = 0
    var questions: [Trivia] = [Trivia]()
    var qArray = [String]()
    var aArray = [String]()
    @IBOutlet weak var finalBtn: UIButton!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var ans1: UIButton!
    @IBOutlet weak var ans2: UIButton!
    @IBOutlet weak var ans3: UIButton!
    @IBOutlet weak var ans4: UIButton!
    @IBOutlet weak var progress: UIProgressView!
    var done = false
    override func viewDidLoad() {
        score = 0
        print("loaded")
        finalBtn.isEnabled = false
        progress.progress = 0.0
        increment = 1.0/Double(numQuestions)
        print (increment)
        ans1.addTarget(self, action: #selector(load), for: .touchUpInside)
        ans2.addTarget(self, action: #selector(load), for: .touchUpInside)
        ans3.addTarget(self, action: #selector(load), for: .touchUpInside)
        ans4.addTarget(self, action: #selector(load), for: .touchUpInside)
        ans1.titleLabel?.numberOfLines = 0
        question.text = questions[0].question
        ans1.setTitle(questions[0].c, for: .normal)
        ans2.setTitle(questions[0].i[0], for: .normal)
        ans3.setTitle(questions[0].i[1], for: .normal)
        ans4.setTitle(questions[0].i[2], for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
    @objc func load(sender: UIButton){
        if sender.titleLabel?.text == questions[0].c{
            score += 1
        }
        if (sender.titleLabel?.text == questions[0].c){
            sender.backgroundColor = UIColor.green
            print("true")
        }
        else{
            sender.backgroundColor = UIColor.red
            print("wrong")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.reset(sender: sender)
        }
        //Thread.sleep(forTimeInterval: 1) //have to chane this to dispatch after
        
    }
    func reset(sender: UIButton){
        sender.backgroundColor = UIColor.systemBlue
        print(score)
        progress.progress += Float(increment)
        //if (questions.count == 1){
            //finalBtn.isEnabled = true
        //}
        questions.remove(at: 0)
        if (questions.isEmpty){
            progress.progress = 0
            finalBtn.isEnabled = true
            finalBtn.sendActions(for: .touchUpInside)
            finalBtn.isEnabled = false
            done = true
            return
        }
        question.text = questions[0].question
        var temp = Int.random(in: 1..<5)
        
        if (temp == 1){
            ans1.setTitle(questions[0].c, for: .normal)
            ans2.setTitle(questions[0].i[0], for: .normal)
            ans3.setTitle(questions[0].i[1], for: .normal)
            ans4.setTitle(questions[0].i[2], for: .normal)
        }
        if (temp == 2){
            ans2.setTitle(questions[0].c, for: .normal)
            ans1.setTitle(questions[0].i[0], for: .normal)
            ans3.setTitle(questions[0].i[1], for: .normal)
            ans4.setTitle(questions[0].i[2], for: .normal)
        }
        if (temp == 3){
            ans3.setTitle(questions[0].c, for: .normal)
            ans2.setTitle(questions[0].i[0], for: .normal)
            ans1.setTitle(questions[0].i[1], for: .normal)
            ans4.setTitle(questions[0].i[2], for: .normal)
        }
        if (temp == 4){
            ans4.setTitle(questions[0].c, for: .normal)
            ans2.setTitle(questions[0].i[0], for: .normal)
            ans3.setTitle(questions[0].i[1], for: .normal)
            ans1.setTitle(questions[0].i[2], for: .normal)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let vc: Results = segue.destination as! Results
        vc.s = "You got \(score) out of \(numQuestions)!"
    }
    
}
