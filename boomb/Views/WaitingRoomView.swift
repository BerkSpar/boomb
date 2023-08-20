//
//  WaitingRoomView.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI

struct WaitingRoomView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @StateObject var controller = GameController.to
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("WAITING ROOM")
                .font(Font.custom("Dimitri", size: 24))
            
            Spacer()
            
            ScrollView {
                 LazyVGrid(columns: columns) {
                     ForEach(controller.waitingList, id: \.username) { value in
                         PlayerTile(name: "\(value.username)")
                     }
                 }
             }
            
            Spacer()
            
            Progress(progress: $controller.progress)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.myYellow)
    }
}

struct WaitingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingRoomView()
    }
}
