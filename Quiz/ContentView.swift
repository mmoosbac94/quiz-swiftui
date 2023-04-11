//
//  ContentView.swift
//  Quiz
//
//  Created by Marvin Moosbacher on 27.12.22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var contentViewModel = ContentViewModel(apiService: ApiService())
    
    var body: some View {
        VStack {
            Spacer()
            if(contentViewModel.showEndResult) {
                Text("Ergebnis").foregroundColor(.white)
                HStack {
                    Text("Richtige Antworten: ").foregroundColor(.white)
                    Text(String(contentViewModel.correctAnswers)).foregroundColor(.green)
                }
                HStack {
                    Text("Falsche Antworten: ").foregroundColor(.white)
                    Text(String(contentViewModel.getWrongAnswers())).foregroundColor(.red)
                    
                }
            } else {
                switch contentViewModel.state {
                case .success:
                    Text(contentViewModel.questionsCache[contentViewModel.currentQuestionIndex].question).multilineTextAlignment(.center).padding(20).foregroundColor(Color.white)
                    
                    VStack {
                        ForEach(contentViewModel.randomAnswers, id: \.self) { answer in
                            Button(answer) {
                                contentViewModel.validateCorrectAnswer(correctAnswer: contentViewModel.questionsCache[contentViewModel.currentQuestionIndex].correctAnswer, userAnswer: answer)
                                contentViewModel.getNextQuestion()
                            }.padding(10).border(.red, width: 3).cornerRadius(8).foregroundColor(Color.white).disabled(contentViewModel.disableAnswers)
                        }.padding(5)
                    }
                    
                case .loading:
                    Text("Loading...").foregroundColor(Color.white)
                case .failure(let error):
                    Text("Fehler: \(error.localizedDescription)").foregroundColor(Color.white)
                case .none:
                    Text("")
                }
                
                if contentViewModel.validation != nil {
                    if(contentViewModel.validation!) {
                        Text("Richtig").padding(60).foregroundColor(Color.green)
                    } else {
                        Text("Falsch").padding(60).foregroundColor(Color.red)
                        Text(contentViewModel.questionsCache[contentViewModel.currentQuestionIndex].correctAnswer).foregroundColor(Color.green)
                    }
                }
            }
            Spacer()
        }
        .onAppear {
            contentViewModel.fetchQuestionsData()
        }
        .ignoresSafeArea().frame(maxWidth: .infinity).background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
