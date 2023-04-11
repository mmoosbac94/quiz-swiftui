//
//  Question.swift
//  Quiz
//
//  Created by Marvin Moosbacher on 27.12.22.
//

import Foundation


struct Question: Codable, Identifiable {
    
    var id: String
    var category: String
    var correctAnswer: String
    var incorrectAnswers: [String]
    
    var question: String
    var tags: [String]
    var difficulty: String
    
}
