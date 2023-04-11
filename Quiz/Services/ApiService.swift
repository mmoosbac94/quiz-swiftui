//
//  ApiService.swift
//  Quiz
//
//  Created by Marvin Moosbacher on 27.12.22.
//

import Foundation
import Combine


class ApiService: ObservableObject {
    
    func questionPublisher() -> AnyPublisher<[Question], Error> {
        let url = URL(string: "https://the-trivia-api.com/api/questions?categories=food_and_drink&limit=10&difficulty=medium")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: [Question].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
