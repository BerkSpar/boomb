//
//  boombApp.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI
import Firebase
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        application.registerForRemoteNotifications()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcm = Messaging.messaging().fcmToken {
            print("FCM Token: \(fcm)")
        }
    }
}

@main
struct boombApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    BoombService.start()
                    
                    InterstitialAd.shared.loadAd(withAdUnitId: AdService.interstitialFinishGame)
                    
                    Analytics.logEvent("open_app", parameters: [
                        AnalyticsParameterItemID: "open_app",
                        AnalyticsParameterItemName: "game",
                        AnalyticsParameterContentType: "game",
                    ])
                }
                .preferredColorScheme(.light)
        }
    }
}
