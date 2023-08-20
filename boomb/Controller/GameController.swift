//
//  GameController.swift
//  boomb
//
//  Created by Felipe Passos on 03/08/23.
//

import Foundation
import SwiftUI

class GameController: ObservableObject {
    
    static var to = GameController()
    
    @Published var lobbyList: [UserModel] = []
    @Published var waitingList: [UserModel] = []
    @Published var quizz: QuizzModel?
    @Published var progress: Double = 1
    
    @Published var username: String = ""
    @Published var channel: String = "campfire"
    
    func resetGame() {
        lobbyList = []
        waitingList = []
        quizz = nil
        progress = 1
        username = ""
        channel = "campfire"
        
        Navigator.to.screen(.enter)
    }
    
    func handleJoinLobby(_ game: GameModel) {
        Navigator.to.screen(.lobby)
        
        lobbyList = game.users
    }
    
    func handleUserJoined(_ user: UserModel) {
        lobbyList.insert(user, at: 0)
    }
    
    func handleGameStarted(_ game: GameModel) {
        Navigator.to.screen(.question)
    }
    
    func handleNewQuizz(_ quizz: QuizzModel) {
        Navigator.to.screen(.question)
        
        self.quizz = quizz
        
        waitingList = []
    }
    
    func handleUserAnwser(_ user: UserModel) {
        waitingList.insert(user, at: 0)
    }
    
    func handleCounter(_ counter: Int) {
        progress = Double(counter) / 10
    }
    
    func handleGameEnded(_ game: GameModel) {
        Navigator.to.screen(.leaderboard)
        
        self.lobbyList = game.users.sorted(by: { oldUser, currentUser in
            return oldUser.score! > currentUser.score!
        })
    }
    
    func handleEndQuizz(_ game: GameModel) {
        progress = 1
        
        let user = game.users.first { e in
            e.username == username
        }
        
        let isRightAnwser = (user?.last_score ?? 0) != 0
        let text = isRightAnwser ? "+\(user?.last_score ?? 0) PTS" : "WRONG ANSWER"
        
        Navigator.to.screen(.anwser(isRightAnwser: isRightAnwser, text: text))
    }
    
    func handleError(_ log: LogModel) {
        HapticsService.shared.notify(.error)
        Navigator.to.showAlert(Alert(title: Text(log.message)))
    }
}
