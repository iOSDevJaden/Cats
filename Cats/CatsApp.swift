//
//  CatsApp.swift
//  Cats
//
//  Created by 김태호 on 2022/07/08.
//

import SwiftUI

@main
struct CatsApp: App {
    @State private var launchScreenPlayed = true
    
    var body: some Scene {
        WindowGroup {
            if launchScreenPlayed {
                LaunchScreen()
                    .onAppear(perform: playLaunchScreen)
            } else {
                MainView()
            }
        }
    }
    
    private func playLaunchScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            launchScreenPlayed.toggle()
        }
    }
}
