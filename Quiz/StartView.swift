//
//  StartView.swift
//  Quiz
//
//  Created by Marvin Moosbacher on 30.12.22.
//

import SwiftUI

struct StartView: View {
    
    @StateObject var startViewModel = StartViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Wer spielt?")
                    .foregroundColor(Color.white)
                    .font(.system(size: 30))
                TextField("Name", text: $startViewModel.nameTextField)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                Divider().background(Color.white)
                NavigationLink(destination: ContentView()) {
                    Text("Start")
                        .foregroundColor(Color.white)
                        .fontWidth(.expanded)
                        .fontWeight(.bold)
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth:3))
                }.padding(40)
                Spacer()
            }.background(Color.black)
        }
        
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
