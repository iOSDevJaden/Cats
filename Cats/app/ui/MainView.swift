//
//  MainView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/08.
//

import SwiftUI

struct MainView: View {
    @State private var currentTab: TabBarItems = .home
    
    var body: some View {
        VStack(spacing: 0) {
            BaseViewFrame(
                viewTitle: currentTab.labelText,
                middle: {
                    switch currentTab {
                    case .home: HomeView()
                    case .search: SearchView()
                    case .upload: UploadView()
                    case .breeds: BreedView()
                    case .profile: ProfileView()
                    }
                })
            getTabItems().padding()
            Spacer().frame(height: 20)
        }
        .ignoresSafeArea()
    }
    
    private func getTabItems() -> some View {
        ZStack {
            HStack(spacing: 30) {
                ForEach(TabBarItems.allCases) { item in
                    item.getButtons(action: { self.currentTab = item })
                        .foregroundColor(
                            self.currentTab == item ? .black : .purple
                        )
                }
            }
        }
    }
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
