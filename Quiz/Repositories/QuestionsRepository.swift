//
//  QuestionsRepository.swift
//  Quiz
//
//  Created by Marvin Moosbacher on 12.01.23.
//

import Foundation
import Combine


class QuestionsRepository {
    
    private let apiService: ApiService
    
    var subscriptions = Set<AnyCancellable>()
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    
    private func getFourRandomQuestions() -> AnyPublisher<[Question], Error> {
        return apiService.questionPublisher()
    }
    
    
    
}
