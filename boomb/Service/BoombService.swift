//
//  BoombService.swift
//  boomb
//
//  Created by Felipe Passos on 03/08/23.
//

import SocketIO
import Foundation

class BoombService: ObservableObject {
    static let manager = SocketManager(
        socketURL: URL(string: "https://boomb-api-71942ea7d526.herokuapp.com")!,
        config: [ .log(false), .compress ]
    )
    
    static var socket: SocketIOClient!
    
    static func start() {
        socket = manager.defaultSocket
        
        socket.on("new-quizz") { data, ack in
            do {
                let dat = try JSONSerialization.data(withJSONObject: data[0])
                let res = try JSONDecoder().decode(QuizzModel.self, from:dat)
                
                print("handle: new-quizz")
                GameController.to.handleNewQuizz(res)
            } catch {
                print(error)
            }
        }

        socket.on("joined-lobby") { data, ack in
            do {
                let dat = try JSONSerialization.data(withJSONObject: data[0])
                let res = try JSONDecoder().decode(GameModel.self, from:dat)

                print("handle: joined-lobby")
                GameController.to.handleJoinLobby(res)
            } catch {
                print(error)
            }
        }
        
        socket.on("game-started") { data, ack in
            do {
                let dat = try JSONSerialization.data(withJSONObject: data[0])
                let res = try JSONDecoder().decode(GameModel.self, from:dat)

                print("handle: game-started")
                GameController.to.handleGameStarted(res)
            } catch {
                print(error)
            }
        }
        
        socket.on("user-joined") { data, ack in
            do {
                let dat = try JSONSerialization.data(withJSONObject: data[0])
                let res = try JSONDecoder().decode(UserModel.self, from:dat)

                print("handle: user-joined")
                GameController.to.handleUserJoined(res)
            } catch {
                print(error)
            }
        }
        
        socket.on("user-anwser") { data, ack in
            do {
                let dat = try JSONSerialization.data(withJSONObject: data[0])
                let res = try JSONDecoder().decode(UserModel.self, from:dat)

                print("handle: user-anwser")
                GameController.to.handleUserAnwser(res)
            } catch {
                print(error)
            }
        }
        
        socket.on("counter") { data, ack in
            print("handle: counter")
            GameController.to.handleCounter(data[0] as! Int)
        }
        
        socket.on("game-ended") { data, ack in
            do {
                let dat = try JSONSerialization.data(withJSONObject: data[0])
                let res = try JSONDecoder().decode(GameModel.self, from:dat)
                
                print("handle: game-ended")
                GameController.to.handleGameEnded(res)
            } catch {
                print(error)
            }
        }
        
        socket.on("end-quizz") { data, ack in
            do {
                let dat = try JSONSerialization.data(withJSONObject: data[0])
                let res = try JSONDecoder().decode(GameModel.self, from:dat)
                
                print("handle: end-quizz")
                GameController.to.handleEndQuizz(res)
            } catch {
                print(error)
            }
        }
        
        socket.on("error") { data, ack in
            do {
                let dat = try JSONSerialization.data(withJSONObject: data[0])
                let res = try JSONDecoder().decode(LogModel.self, from:dat)
                
                print("handle: error")
                GameController.to.handleError(res)
            } catch {
                print(error)
            }
        }
        
        socket.connect()
    }
    
    static func joinLobby(_ username: String, _ channel: String) {
        if (username.isEmpty) { return }
        
        let data = ["username": username, "channel": channel]

        socket.emit("join-lobby", data)
    }
    
    static func startGame(_ username: String, _ channel: String) {
        if (username.isEmpty) { return }
        
        let data = ["username": username, "channel": channel]

        socket.emit("start-game", data)
    }
    
    static func answer(_ username: String, _ channel: String,_ quizzId: Int,_ answerId: Int) {
        if (username.isEmpty) { return }
        
        let data: [String:Any] = ["username": username, "channel": channel, "quizz_id": quizzId, "answer_id": answerId]
        
        socket.emit("answer", data)
    }
}
