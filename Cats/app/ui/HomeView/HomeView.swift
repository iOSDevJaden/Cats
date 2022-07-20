//
//  HomeView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/20.
//

import SwiftUI

/**
 * MARK: - Home View
 *  Home View shows User's Favourite cat pictures in large scale on the section first.
 *  And then shows Vote-up cat pictures in large scale.
 *  No order pictures considered.
 */

struct HomeView: View {
    @ObservedObject private var vm = HomeViewModel()
    
    var body: some View {
        Form {
            if vm.favourites.isEmpty {
                Text("No favourite cat pictures")
            } else {
                Section(
                    content: {
                        ForEach(vm.favourites) { image in
                            if let url = image.image?.url {
                                AsyncImgView(url)
                            }
                        }
                    },
                    header: {
                        Text("My Favourite Views")
                    })
            }
            
            if vm.voteUps.isEmpty {
                Text("No Vote-up cat pictures")
            } else {
                Section(
                    content: {
                        ForEach(vm.voteUps) { image in
                            if let url = image.url {
                                AsyncImgView(url)
                            }
                        }
                    },
                    header: {
                        Text("My Vote-up Views")
                    })
            }
        }
        .onAppear(perform: vm.getFavouriteImages)
        .onAppear(perform: vm.getVoteUpImages)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
