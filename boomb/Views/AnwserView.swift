//
//  AnwserView.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI

struct AnwserView: View {
    var isRightAnwser: Bool
    var text: String
    
    func getBackground() -> Color {
        return isRightAnwser ? Color.myGreen : Color.myRed
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Spacer()
            
            Text(text)
                .font(Font.custom("Dimitri", size: 36))
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(getBackground())
        .onAppear {
            if (isRightAnwser) {
                HapticsService.shared.notify(.success)
            } else {
                HapticsService.shared.notify(.error)
            }
        }
    }
}

struct AnwserView_Previews: PreviewProvider {
    static var previews: some View {
        AnwserView(
            isRightAnwser: true,
            text: "100 pts"
        )
        
        AnwserView(
            isRightAnwser: false,
            text: "Wrong Anwser"
        )
    }
}
