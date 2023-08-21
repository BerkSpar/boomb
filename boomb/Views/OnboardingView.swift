//
//  OnboardingView.swift
//  bud
//
//  Created by Felipe Passos on 07/06/23.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Text("Welcome.")
                .font(.system(size: 40).monospaced())
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 24) {
                SimpleListTile(
                    iconColor: .black,
                    iconSystemName: "clock.fill",
                    title: "Fast and Fierce",
                    subtitle: "Each round is a race against the clock. Hurry up and bring your A-game!"
                )
                
                SimpleListTile(
                    iconColor: .black,
                    iconSystemName: "questionmark.square.fill",
                    title: "Dynamic Quizzes",
                    subtitle: "Varied categories to keep the adrenaline pumping. From history to pop, we've got it all!"
                )
                
                SimpleListTile(
                    iconColor: .black,
                    iconSystemName: "figure.boxing",
                    title: "Friendly Competition",
                    subtitle: "Play with friends or make new ones from around the world. Boomb is about fun and friendship."
                )
            }
            
            Spacer()
            
            MyButton(
                label: "LET'S GO!!!",
                color: Color.myBlue
            ) {
                Navigator.to.screen(.enter)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.myYellow)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
