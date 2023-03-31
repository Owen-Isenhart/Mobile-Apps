//
//  Model.swift
//  Wordle
//
//  Created by Isenhart, Owen E on 3/23/23.
//

import Foundation

extension Character {
    
    //converts a character to uppercase
    func convertToUpperCase() -> Character {
        if(self.isUppercase){
            return self
        }
        return Character(self.uppercased())
    }
}

struct Guess{
    var word: String
    var correct: [Int] //0 for not in word, 1 for in word but wrong spot, 2 for in word and correct spot
    var letters: [String]
    var completed: Bool
    var deadLetters: [String]
    init(w: String){
        word = w
        correct = [0, 0, 0, 0, 0] //everything set to not in word initially
        letters = ["", "", "", "", ""]
        deadLetters = ["", "", "", "", ""]
        completed = false
    }
    
    
    
    mutating func compareGuess(target: String){
        //guess characters
        
        let g1 = word.index(word.startIndex, offsetBy: 0)
        let g2 = word.index(word.startIndex, offsetBy: 1)
        let g3 = word.index(word.startIndex, offsetBy: 2)
        let g4 = word.index(word.startIndex, offsetBy: 3)
        let g5 = word.index(word.startIndex, offsetBy: 4)
        letters = [String(word[g1]), String(word[g2]), String(word[g3]), String(word[g4]), String(word[g5])]
        
        var guessChars: [Character] = [word[g1], word[g2], word[g3], word[g4], word[g5]]
        var targetChars: [Character] = [target[g1], target[g2], target[g3], target[g4], target[g5]]
        
        for i in 0...4{
            guessChars[i] = guessChars[i].convertToUpperCase()
            targetChars[i] = targetChars[i].convertToUpperCase()
        }
        var target2 = target.uppercased()
        var i = 0
        for char in guessChars {
            if char == targetChars[i]{
                correct[i] = 2
            }
            else if (target2.contains(String(char))){
                correct[i] = 1
            }
            else{
                correct[i] = 0
                deadLetters[i] = String(char)
            }
            i += 1
        }
        if (correct == [2, 2, 2, 2, 2]){
            completed = true
        }
    }
}
struct dict{
    var words: [String]
    init?(){
        var temp: String = ""
        if let path = Bundle.main.path(forResource: "dictionary", ofType: "txt") {
          do {
            temp = try String(contentsOfFile: path, encoding: .utf8)
              words = temp.components(separatedBy: "\n")
          } catch let error {
              words = []
            // Handle error here
          }
        }
        else{
            words = []
        }
    }
}
