//
//  QuizzModel.swift
//  boomb
//
//  Created by Felipe Passos on 03/08/23.
//

import Foundation

struct QuizzModel: Codable {
    var id: Int
    var question: String
    var answers: [AnwserModel]
}
