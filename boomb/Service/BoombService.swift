//
//  BoombService.swift
//  boomb
//
//  Created by Felipe Passos on 03/08/23.
//

import SocketIO
import Foundation
import FirebaseAnalytics

class BoombService: ObservableObject {
    static let manager = SocketManager(
        socketURL: URL(string: "https://boomb-api.onrender.com")!,
        config: [ .log(false), .compress ]
    )
    
    static var socket: SocketIOClient!
    
    static func start() {
        socket = manager.defaultSocket
        
        socket.on("new-quizz") { data, ack in
            IO.handleSocketDecoding(event: "new-quizz", data: data, type: QuizzModel.self) { res in
                print("handle: new-quizz")
                GameController.to.handleNewQuizz(res)
            }
        }

        socket.on("joined-lobby") { data, ack in
            IO.handleSocketDecoding(event: "joined-lobby", data: data, type: GameModel.self) { res in
                print("handle: joined-lobby")
                GameController.to.handleJoinLobby(res)
            }
        }
        
        socket.on("game-started") { data, ack in
            IO.handleSocketDecoding(event: "game-started", data: data, type: GameModel.self) { res in
                print("handle: game-started")
                GameController.to.handleGameStarted(res)
            }
        }
        
        socket.on("user-joined") { data, ack in
            IO.handleSocketDecoding(event: "user-joined", data: data, type: UserModel.self) { res in
                print("handle: user-joined")
                GameController.to.handleUserJoined(res)
            }
        }
        
        socket.on("user-anwser") { data, ack in
            IO.handleSocketDecoding(event: "user-anwser", data: data, type: UserModel.self) { res in
                print("handle: user-anwser")
                GameController.to.handleUserAnwser(res)
            }
        }
        
        socket.on("counter") { data, ack in
            print("handle: counter")
            GameController.to.handleCounter(data[0] as! Int)
        }
        
        socket.on("game-ended") { data, ack in
            IO.handleSocketDecoding(event: "game-ended", data: data, type: GameModel.self) { res in
                print("handle: game-ended")
                GameController.to.handleGameEnded(res)
            }
        }
        
        socket.on("end-quizz") { data, ack in
            IO.handleSocketDecoding(event: "end-quizz", data: data, type: GameModel.self) { res in
                print("handle: end-quizz")
                GameController.to.handleEndQuizz(res)
            }
        }
        
        socket.on("error") { data, ack in
            IO.handleSocketDecoding(event: "error", data: data, type: LogModel.self) { res in
                print("handle: error")
                GameController.to.handleError(res)
            }
        }
        
        socket.connect()
    }
    
    static func joinLobby(_ username: String, _ channel: String) {
        if (username.isEmpty) { return }
        
        let data = ["username": username, "channel": channel]

        socket.emit("join-lobby", data)
        
        Analytics.logEvent("join_group", parameters: [
            "group_id": channel,
        ])
    }
    
    static func startGame(_ username: String, _ channel: String) {
        if (username.isEmpty) { return }
        
        let data = ["username": username, "channel": channel]
        
        socket.emit("start-game", data)
        
        Analytics.logEvent("start_game", parameters: [
            AnalyticsParameterItemID: channel,
            AnalyticsParameterItemName: "game",
            AnalyticsParameterContentType: "game",
        ])
    }
    
    static func answer(_ username: String, _ channel: String,_ quizzId: Int,_ answerId: Int) {
        if (username.isEmpty) { return }
        
        let data: [String:Any] = [
            "username": username,
            "channel": channel,
            "quizz_id": quizzId,
            "answer_id": answerId
        ]
        
        socket.emit("answer", data)
        
        Analytics.logEvent("select_content", parameters: [
            "content_type": "answer",
            "content_id": "answerId",
        ])
    }
}
