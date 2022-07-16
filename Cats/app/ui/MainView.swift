//
//  MainView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/08.
//

import SwiftUI

struct MainView: View {
    @State private var currentTab: TabBarItems = .vote
    
    var body: some View {
        VStack(spacing: 0) {
            BaseViewFrame(
                viewTitle: currentTab.text,
                middle: {
                    switch currentTab {
                    case .vote:      VoteView()
                    case .breed:     BreedView()
                    case .favourite: FavouriteView()
                    case .search:    SearchView()
                    case .upload:    UploadView()
                    }
                })
            getTabItems()
                .frame(height: 120)
        }
        .ignoresSafeArea()
    }
    
    private func getTabItems() -> some View {
        ZStack {
            Color
                .black
                .opacity(0.2)
            HStack(spacing: 30) {
                ForEach(TabBarItems.allCases) { item in
                    item.getTabItemButtons(action: { self.currentTab = item })
                }
            }
            .foregroundColor(.purple)
            .offset(x: 0, y: -10)
        }
    }
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
