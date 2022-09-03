//
//  CatsApp.swift
//  Cats
//
//  Created by 김태호 on 2022/07/08.
//

import SwiftUI
import NotificationCenter

@main
struct CatsApp: App {
    @UIApplicationDelegateAdaptor
    private var appDelegate: AppDelegateAdapter
    
    @StateObject private var homeVM = HomeViewModel()
    @StateObject private var searchVM = SearchViewModel()
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
                    .environmentObject(searchVM)
                    .environmentObject(breedVM)
            }
        }
    }
    
    private func setupHomeViewModel() {
        homeVM.getFavouriteImages()
    }
    
    private func setupSearchViewModel() {
        searchVM.loadCurrentPage()
        searchVM.loadNumberOfImagePerPage()
        searchVM.getImages()
    }
    
    private func setupBreedViewModel() {
        breedVM.loadBreedModelsIfExists()
    }
    
    private func playLaunchScreen() {
        setupHomeViewModel()
        
        setupSearchViewModel()
        
        setupBreedViewModel()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            launchScreenPlayed.toggle()
        }
    }
}

final class AppDelegateAdapter: NSObject, UIApplicationDelegate {
    private var notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

extension AppDelegateAdapter: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound])
    }
}
