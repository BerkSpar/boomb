//
//  ContentView.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI

enum Screen {
    case enter
    case question
    case anwser(isRightAnwser: Bool, text: String)
    case leaderboard
    case waitingRoom
    case lobby
    case onboarding
}

class Navigator: ObservableObject {
    static var to = Navigator()
    
    @Published var screen: Screen = .onboarding
    @Published var isAlertPresented: Bool = false
    @Published var alert: Alert = Alert(title: Text(""))
    
    func showAlert(_ alert: Alert) {
        self.alert = alert
        isAlertPresented = true
    }
    
    func screen(_ screen: Screen) {
        self.screen = screen
    }
}

struct ContentView: View {
    @StateObject var navigator = Navigator.to
    
    var body: some View {
        ZStack {
            switch(navigator.screen) {
                case .enter: EnterView()
                case .question: QuestionView()
                case .anwser(let isRightAnwser, let text): AnwserView(isRightAnwser: isRightAnwser, text: text)
                case .waitingRoom: WaitingRoomView()
                case .leaderboard: LeaderboardView()
                case .lobby: LobbyView()
                case .onboarding: OnboardingView()
            }
        }
        .alert(isPresented: $navigator.isAlertPresented) {
            navigator.alert
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
