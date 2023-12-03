//
//  EnterView.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI
import FirebaseAnalytics

struct EnterView: View {
    @State private var username = ""
    @State private var room = ""
    @StateObject var controller = GameController.to
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Spacer()
            
            Text("USERNAME")
                .font(Font.custom("Dimitri", size: 16))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            MyTextField(text: $username)
            
            Text("ROOM")
                .font(Font.custom("Dimitri", size: 16))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            MyTextField(text: $room)
            
            Spacer()
            
            MyButton(label: "ENTER") {
                controller.username = username
                controller.channel = room

                BoombService.joinLobby(controller.username, controller.channel)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.myYellow)
    }
}

struct EnterView_Previews: PreviewProvider {
    static var previews: some View {
        EnterView()
    }
}
