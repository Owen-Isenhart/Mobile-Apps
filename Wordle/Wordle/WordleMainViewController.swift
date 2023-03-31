import UIKit
class WordleMainViewController: UIViewController {
    var model: [Guess] = [Guess]()
    var diction = dict()
    @IBOutlet var allLabels: [UILabel]!
    @IBOutlet var row1Labels: [UILabel]!
    @IBOutlet weak var row1: UIStackView!
    @IBOutlet weak var row2: UIStackView!
    @IBOutlet weak var row3: UIStackView!
    @IBOutlet weak var row4: UIStackView!
    @IBOutlet weak var row5: UIStackView!
    @IBOutlet weak var row6: UIStackView!
    @IBOutlet weak var deadLetters: UILabel!
    @IBOutlet weak var word: UITextField!
    var wordCount = 0
    var guessCount = 0
    var targetWord = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        word.autocorrectionType = .no
        word.addTarget(self, action: #selector(guessMade), for: .editingDidEndOnExit)
        targetWord = rndWord()
    }
    func rndWord() -> String{
        var temp: [String] = []
        for str in diction!.words{
            if str.count == 5{
                temp.append(str)
            }
        }
        return temp.randomElement()!
    }
    @objc func guessMade(){
        if let text = word.text{
            if (text.count == 5 && diction!.words.contains(text.uppercased())){
                var guess = Guess(w: text)
                guess.compareGuess(target: targetWord)
                print (allLabels.count)
                var labels: [UILabel]! = [allLabels[guessCount], allLabels[guessCount+1], allLabels[guessCount+2], allLabels[guessCount+3], allLabels[guessCount+4]]
                var counter = 0
                for i in guess.correct{
                    if (i == 1){
                        labels[counter].backgroundColor = UIColor.yellow
                    }
                    else if (i == 2){
                        labels[counter].backgroundColor = UIColor.green
                    }
                    labels[counter].textAlignment = .center
                    labels[counter].font = UIFont(name: "Arial", size: 60.0)
                    labels[counter].textColor = UIColor.white
                    labels[counter].text = guess.letters[counter].uppercased()
                    counter += 1
                }
                if (guess.completed){ // the guess is correct
                     var dialogMessage = UIAlertController(title: "You win!", message: "Congratulations", preferredStyle: .alert)
                     
                     let ok = UIAlertAction(title: "Play again", style: .default, handler: { (action) -> Void in
                         // reset the game
                         self.guessCount = 0
                         self.wordCount = 0
                         self.deadLetters.text = "Dead letters: "
                         self.targetWord = self.rndWord()
                         for lab in self.allLabels{
                             lab.backgroundColor = UIColor.darkGray
                             lab.text = ""
                         }
                      })
                     dialogMessage.addAction(ok)
                     self.present(dialogMessage, animated: true, completion: nil)
                }
                guessCount += 5
                wordCount += 1
                if (wordCount == 6){
                    var dialogMessage = UIAlertController(title: "You lost!", message: "Word was: \(targetWord)", preferredStyle: .alert)
                    
                    let ok = UIAlertAction(title: "Play again", style: .default, handler: { (action) -> Void in
                        // reset the game
                        self.guessCount = 0
                        self.wordCount = 0
                        self.deadLetters.text = "Dead letters: "
                        self.targetWord = self.rndWord()
                        for lab in self.allLabels{
                            lab.backgroundColor = UIColor.darkGray
                            lab.text = ""
                        }
                     })
                    
                    dialogMessage.addAction(ok)
                    self.present(dialogMessage, animated: true, completion: nil)
                }
                for l in guess.deadLetters{
                    if let text = deadLetters.text{
                        if !l.isEmpty && !text.contains(Character(l)){
                            deadLetters.text = "\(text) \(l)"
                        }
                    }
                }
            }
        }
        word.text = ""
    }
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue){
        
    }
}
