//
//  LobbyView.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI

struct LobbyView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @StateObject var controller = GameController.to
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("LOBBY")
                .font(Font.custom("Dimitri", size: 24))
            
            Text("ROOM: \(controller.channel)")
                .font(Font.custom("Dimitri", size: 16))
            
            Spacer()
            
            ScrollView {
                 LazyVGrid(columns: columns) {
                     ForEach(controller.lobbyList, id: \.username) { value in
                         PlayerTile(name: "\(value.username)")
                     }
                 }
             }
            
            Spacer()
            
            MyButton(label: "START GAME") {
                BoombService.startGame(controller.username, controller.channel)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.myYellow)
    }
}

struct LobbyView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyView()
    }
}
