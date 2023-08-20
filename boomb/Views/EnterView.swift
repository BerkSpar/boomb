//
//  EnterView.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI

struct EnterView: View {
    @State private var text = ""
    @StateObject var controller = GameController.to
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("USERNAME")
                .font(Font.custom("Dimitri", size: 16))
                .foregroundColor(.black)
            
            MyTextField(text: $text)
            
            MyButton(label: "ENTER") {
                controller.username = text

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
