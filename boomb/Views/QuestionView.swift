//
//  QuestionView.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI
import GoogleMobileAds

struct QuestionView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @StateObject var controller = GameController.to
    
    @State var height: CGFloat = 0 //Height of ad
    @State var width: CGFloat = 0 //Width of ad
    
    func setFrame() {
        //Get the frame of the safe area
        let safeAreaInsets = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero
        let frame = UIScreen.main.bounds.inset(by: safeAreaInsets)
        
        //Use the frame to determine the size of the ad
        let adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(frame.width)
        
        //Set the ads frame
        self.width = adSize.size.width
        self.height = adSize.size.height
    }
    
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
            
            BannerAd(adUnitId: AdService.bannerInGame)
                .frame(width: width, height: height, alignment: .center)
                .onAppear {
                    setFrame()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    setFrame()
                }
        }
        .padding([.leading, .trailing, .top], 24)
        .ignoresSafeArea(edges: .bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.myYellow)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
