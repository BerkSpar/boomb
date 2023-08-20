//
//  GameModel.swift
//  boomb
//
//  Created by Felipe Passos on 03/08/23.
//

import Foundation

struct GameModel: Codable {
    var current_round: Int
    var max_rounds: Int
    var started: Bool
    var users: [UserModel]
}
