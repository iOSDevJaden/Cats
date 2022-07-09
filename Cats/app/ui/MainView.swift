//
//  MainView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/08.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            VoteView()
                .tabItem {
                    Image(systemName: "archivebox")
                    Text("vote")
                }
            BreedView()
                .tabItem {
                    Image(systemName: "sun.min")
                    Text("Breeds")
                }
            Text("Image / Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            Text("Favorite")
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorite")
                }
            Text("Upload")
                .tabItem {
                    Image(systemName: "arrow.up.bin")
                    Text("Upload")
                }
        }
        .tabViewStyle(.automatic)
    }
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
