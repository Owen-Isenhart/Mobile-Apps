//
//  ViewController.swift
//  Trivia
//
//  Created by Isenhart, Owen E on 2/10/23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var questionRange: UILabel!
    @IBOutlet weak var questionsText: UITextField!
    var quiz = QuizModel()
    var cat = ""
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.picker.delegate = self
        self.picker.dataSource = self
        
        pickerData = quiz.categories
        cat = pickerData[0]
        questionsText.addTarget(self, action: #selector(done), for: .editingDidEndOnExit)
        
    }
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }

       // Number of columns of data
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       // The number of rows of data
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerData.count
       }
       
       // The data to return fopr the row and component (column) that's being passed in
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           questionRange.text = "1 to 50"
           cat = pickerData[row]
           return pickerData[row]
       }
    
        @objc func done(){ //have to press enter to send the data
            let navVC = tabBarController?.viewControllers![1] as! UINavigationController
            let playControl = navVC.topViewController as! PlayScreen
            print (cat)
            var trivia = quiz.makeQuiz(category: cat, quantity: Int(questionsText.text!)!)
            playControl.numQuestions = Int(questionsText.text!)!
            playControl.questions = trivia
            trivia.removeAll()
        }

}

