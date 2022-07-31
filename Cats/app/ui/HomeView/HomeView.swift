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
            ForEach(vm.favouriteImages, id: \.favouriteId) { images in
                if let imageUrl = images.imageModel.imageUrl {
                    AsyncImgView(imageUrl)
                }
            }
        }
        .onAppear(perform: vm.getFavouriteImages)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
