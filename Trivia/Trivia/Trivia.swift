//
//  Trivia.swift
//  Trivia
//
//  Created by Isenhart, Owen E on 2/10/23.
//

import Foundation

class Trivia{
    var question: String
    var c: String
    var i: [String]
    init(q: String, correct: String, incorrect: [String]){
        question = q
        c = correct
        i = incorrect
    }
}
