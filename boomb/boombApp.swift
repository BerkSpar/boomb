//
//  boombApp.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI

@main
struct boombApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                     BoombService.start()
                }
                .preferredColorScheme(.light)
        }
    }
}
