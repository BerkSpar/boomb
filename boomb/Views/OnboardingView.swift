//
//  OnboardingView.swift
//  bud
//
//  Created by Felipe Passos on 07/06/23.
//

import SwiftUI
import FirebaseAnalytics
import AppTrackingTransparency
import AdSupport
import FirebaseMessaging

//NEWLY ADDED PERMISSIONS FOR iOS 14
func requestPermission() {
    if #available(iOS 14, *) {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                // Tracking authorization dialog was shown
                // and we are authorized
                print("Authorized")
                
                Analytics.logEvent("tracking_authorized", parameters: nil)
                
                // Now that we are authorized we can get the IDFA
                print(ASIdentifierManager.shared().advertisingIdentifier)
            case .denied:
                // Tracking authorization dialog was
                // shown and permission is denied
                Analytics.logEvent("tracking_denied", parameters: nil)
                print("Denied")
            case .notDetermined:
                // Tracking authorization dialog has not been shown
                Analytics.logEvent("tracking_not_determined", parameters: nil)
                print("Not Determined")
            case .restricted:
                Analytics.logEvent("tracking_restricted", parameters: nil)
                print("Restricted")
            @unknown default:
                Analytics.logEvent("tracking_unknown", parameters: nil)
                print("Unknown")
            }
        }
    }
}
//

struct OnboardingView: View {
    init() {
        Analytics.logEvent("tutorial_begin", parameters: nil)
    }
    
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
                requestPermission()
                Navigator.to.screen(.enter)
                Analytics.logEvent("tutorial_complete", parameters: nil)
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
