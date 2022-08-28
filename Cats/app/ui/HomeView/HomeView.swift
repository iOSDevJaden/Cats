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
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        Form {
            ForEach(vm.favouriteImages, id: \.favouriteId) { images in
                if let imageUrl = images.imageModel.imageUrl {
                    VStack(alignment: .leading) {
                        AsyncImgView(imageUrl)
                            .cornerRadius(20)
                        Button(
                            action: {
                                vm.deleteFavouriteImage(image: images.favouriteId)
                            },
                            label: {
                                getButtonLabel(favouriteId: images.favouriteId)
                            })
                        .background(
                            Color.black.opacity(0.3)
                                .cornerRadius(5)
                        )
                    }
                }
            }
        }
    }
    
    private func getButtonLabel(favouriteId: String) -> some View {
        HStack {
            Image(systemName: "trash")
                .resizable()
                .frame(width: 30, height: 40)
                .padding(5)
            Text(favouriteId)
                .font(.title3)
                .bold()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
