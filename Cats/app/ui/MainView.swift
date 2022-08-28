//
//  MainView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/08.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var homeVM: HomeViewModel
    @EnvironmentObject private var breedVM: BreedViewModel
    
    @State private var currentTab: TabBarItems = .home
    @State private var showUploadView = false
    
    var body: some View {
        VStack(spacing: 0) {
            BaseViewFrame(
                viewTitle: currentTab.labelText,
                middle: {
                    switch currentTab {
                    case .home:     HomeView()
                    case .search:   SearchView()
                    case .breeds:   BreedView()
                    case .settings: SettingsView()
                        
                    default: EmptyView()
                    }
                })
            getTabItems().padding()
                .sheet(isPresented: $showUploadView) {
                    UploadView()
                }
            Spacer().frame(height: 20)
        }
        .environmentObject(homeVM)
        .environmentObject(breedVM)
        .ignoresSafeArea()
    }
    
    private func getTabItems() -> some View {
        ZStack {
            HStack(spacing: 30) {
                ForEach(TabBarItems.allCases) { item in
                    item.getButtons(action: {
                        setCurrentTab(to: item)
                    })
                    .foregroundColor(
                        self.currentTab == item ? Color("TabSelectedColor") : .purple
                    )
                }
            }
        }
    }
    
    private func setCurrentTab(to item: TabBarItems) {
        switch item {
        case .upload: self.showUploadView.toggle()
        default:      self.currentTab = item
        }
    }
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
