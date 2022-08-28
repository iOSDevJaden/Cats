//
//  CatsApp.swift
//  Cats
//
//  Created by 김태호 on 2022/07/08.
//

import SwiftUI

@main
struct CatsApp: App {
    @StateObject private var homeVM = HomeViewModel()
    @StateObject private var breedVM = BreedViewModel()
    
    @State private var launchScreenPlayed = true
    
    var body: some Scene {
        WindowGroup {
            if launchScreenPlayed {
                LaunchScreen()
                    .onAppear(perform: playLaunchScreen)
            } else {
                MainView()
                    .environmentObject(homeVM)
                    .environmentObject(breedVM)
            }
        }
    }
    
    private func setupHomeViewModel() {
        homeVM.getFavouriteImages()
    }
    
    private func setupBreedViewModel() {
        breedVM.loadBreedModelsIfExists()
    }
    
    private func playLaunchScreen() {
        setupHomeViewModel()
        
        setupBreedViewModel()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            launchScreenPlayed.toggle()
        }
    }
}
