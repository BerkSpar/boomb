//
//  LeaderboardView.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI
import FirebaseAnalytics
import ConfettiSwiftUI

struct LeaderboardView: View {
    @StateObject var controller = GameController.to
    @State var counter = 1
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("LEADERBOARD")
                .font(Font.custom("Dimitri", size: 24))
            
            Spacer()
            
            Leaderboard(
                firstPerson: controller.lobbyList.find(at: 0),
                secondPerson: controller.lobbyList.find(at: 1),
                thirdPerson: controller.lobbyList.find(at: 2)
            )
                        
            if (controller.lobbyList.count > 3) {
                Text("OTHERS")
                    .font(Font.custom("Dimitri", size: 16))
                    .padding(.top, 8)

                ScrollView {
                    ForEach(controller.lobbyList[3...controller.lobbyList.count-1], id: \.username) { value in
                        PlayerTile(
                            name: value.username,
                            subtitle: "\(value.score ?? 0) pts",
                            size: 50,
                            isHorizontal: true
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                 }
            } else {
                Spacer()
            }
            
            MyButton(label: "EXIT GAME") {
                controller.resetGame()
                
                Analytics.logEvent("finish-game", parameters: [
                    AnalyticsParameterItemID: "finish",
                    AnalyticsParameterItemName: "finish",
                    AnalyticsParameterContentType: "game",
                ])
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.myYellow)
        .confettiCannon(counter: $counter, num: 100, colors: [Color.myBlue, Color.myPurple, Color.myRed], rainHeight: 1000.0, radius: 500.0, repetitions: 3, repetitionInterval: 0.5)
        .onAppear {
            counter += 1
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
