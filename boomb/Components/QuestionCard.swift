//
//  QuestionCard.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI

struct QuestionCard: View {
    var label: String
    var onTap: () -> Void
    
    @State private var isClicked = false
    
    var body: some View {
        Button {
            onTap()
            
            withAnimation(.easeInOut(duration: 0.3)) {
                isClicked = true
            }
        } label: {
            Text(label)
                .font(.system(size: 16).monospaced())
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding(16)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 100,
                    alignment: .center
                )
                .background(isClicked ? Color.myBlue : .black)
        }
        .buttonStyle(.plain)
//        .animation(.easeIn, value: isClicked)
    }
}

struct QuestionCard_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCard(label: "Pedro Cabal") {
            print("ihu")
        }
    }
}
