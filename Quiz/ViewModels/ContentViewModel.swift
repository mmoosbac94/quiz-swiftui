//
//  ContentViewModel.swift
//  Quiz
//
//  Created by Marvin Moosbacher on 12.01.23.
//

import Foundation
import Combine


enum ContentState {
    case loading
    case success
    case failure(Error)
}


class ContentViewModel: ObservableObject {
    
    private let apiService: ApiService
    
    @Published var state: ContentState? = nil
    
    @Published var validation: Bool?
    
    @Published var disableAnswers: Bool = false
    
    @Published var currentQuestionIndex: Int = 0
    
    @Published var showEndResult = false
    
    var questionsCache: [Question] = []
    
    var randomAnswers: [String] = []
    
    var correctAnswers: Int = 0
    
    var cancellables = Set<AnyCancellable>()
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getNextQuestion() {
        disableAnswers = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            if(!(self.currentQuestionIndex == self.questionsCache.count - 1)) {
                self.currentQuestionIndex+=1
                self.randomAnswers = self.setRandomizedAnswers(randomQuestion: self.questionsCache[self.currentQuestionIndex])
                self.validation = nil
                self.disableAnswers = false
            }
        }
    }
    
    func setRandomizedAnswers(randomQuestion: Question) -> [String] {
        var allAnswers = [String]()
        allAnswers.append(contentsOf: randomQuestion.incorrectAnswers)
        allAnswers.append(randomQuestion.correctAnswer)
        return allAnswers.shuffled()
    }
    
    func fetchQuestionsData() {
        state = ContentState.loading
        apiService.questionPublisher().sink { completion in
            switch completion {
            case .failure(let error):
                print("Failed with error: \(error)")
                self.state = ContentState.failure(error)
                return
            case .finished:
                print("Successfully finished!")
            }
        } receiveValue: { questions in
            self.questionsCache.append(contentsOf: questions)
            self.randomAnswers = self.setRandomizedAnswers(randomQuestion: self.questionsCache[self.currentQuestionIndex])
            self.state = ContentState.success
        }.store(in: &cancellables)
    }
    
    func validateCorrectAnswer(correctAnswer: String, userAnswer: String) {
        
        print("Index: \(currentQuestionIndex)")
        
        if(correctAnswer == userAnswer) {
            correctAnswers+=1
            validation = true
        } else {
            validation = false
        }
        
        if(currentQuestionIndex == questionsCache.count - 1) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.showEndResult = true
            }
        }
    }
    
    func getWrongAnswers() -> Int{
        return (questionsCache.count) - correctAnswers
    }
    
}
