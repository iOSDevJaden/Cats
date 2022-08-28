//
//  CatsApp.swift
//  Cats
//
//  Created by 김태호 on 2022/07/08.
//

import SwiftUI

@main
struct CatsApp: App {
    @StateObject private var breedVM = BreedViewModel()
    
    @State private var launchScreenPlayed = true
    
    var body: some Scene {
        WindowGroup {
            if launchScreenPlayed {
                LaunchScreen()
                    .onAppear(perform: playLaunchScreen)
            } else {
                MainView()
                    .environmentObject(breedVM)
            }
        }
    }
    
    private func setupBreedViewModel() {
        breedVM.loadBreedModelsIfExists()
    }
    
    private func playLaunchScreen() {
        setupBreedViewModel()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            launchScreenPlayed.toggle()
        }
    }
}
