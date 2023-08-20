//
//  QuestionView.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI

struct QuestionView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @StateObject var controller = GameController.to
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("QUESTION")
                .font(Font.custom("Dimitri", size: 24))
            
            Spacer()
            
            if (controller.quizz != nil) {
                Text(controller.quizz!.question)
                    .font(.system(size: 16).monospaced())
                    .bold()
                    .multilineTextAlignment(.center)
                
                LazyVGrid(columns: columns) {
                    ForEach(controller.quizz!.answers, id: \.id) { value in
                        QuestionCard(label: "\(value.text)") {
                            HapticsService.shared.play(.light)
                            Navigator.to.screen(.waitingRoom)
                            BoombService.answer(controller.username, controller.channel, controller.quizz!.id, value.id)
                        }
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

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
