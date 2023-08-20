//
//  Leaderboard.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI

struct Leaderboard: View {
    var firstPerson: UserModel?
    var secondPerson: UserModel?
    var thirdPerson: UserModel?
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack {
                if (secondPerson != nil) {
                    PlayerTile(
                        name: secondPerson!.username,
                        subtitle: "\(secondPerson?.score ?? 0) PTS"
                    )
                }
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(Color.myGreen)
            }
            
            VStack {
                if (firstPerson != nil) {
                    PlayerTile(
                        name: firstPerson!.username,
                        subtitle: "\(firstPerson?.score ?? 0) PTS"
                    )
                }
                    
                
                Rectangle()
                    .frame(height: 75)
                    .foregroundColor(Color.myGreen)
            }
            
            VStack {
                if (thirdPerson != nil) {
                    PlayerTile(
                        name: thirdPerson!.username,
                        subtitle: "\(thirdPerson?.score ?? 0) PTS"
                    )
                }
                
                Rectangle()
                    .frame(height: 35)
                    .foregroundColor(Color.myGreen)
            }
        }
    }
}

struct Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        Leaderboard(
            firstPerson: UserModel(username: "afonso"),
            secondPerson: UserModel(username: "alves"),
            thirdPerson: UserModel(username: "Bea")
        )
    }
}
