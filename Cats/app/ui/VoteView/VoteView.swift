//
//  VoteView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/08.
//

import SwiftUI

struct VoteView: View, ImageViewProtocol {
    @ObservedObject var vm = VoteViewModel()
    
    var body: some View {
        VStack {
            getRefreshButton()
            
            HStack {
                getVoteUpButton()
                getVoteDownButton()
            }
            
            getFavouriteButton()
            
            ScrollView {
                if let imageUrl = vm.image?.url,
                   let image = getImage(imageUrl: imageUrl) {
                    image
                        .resizable()
                        .scaledToFit()
                } else {
                    ProgressView()
                }
            }
            Spacer()
        }
        .onAppear(perform: vm.getSingleImage)
    }
    
    private func getFavouriteButton() -> some View {
        Button(
            action: {},
            label: { Text("Favorite") })
    }
    
    private func getVoteDownButton() -> some View {
        Button(
            action: {
                if let image = vm.image {
                    vm.voteImage(image: image, vote: .down)
                }
            },
            label: {
                Text("Nope it")
                    .font(.title)
                    .bold()
            })
    }
    
    private func getVoteUpButton() -> some View {
        Button(
            action: {
                if let image = vm.image {
                    vm.voteImage(image: image, vote: .up)
                }
            },
            label: {
                Text("Love it")
                    .font(.title)
                    .bold()
            })
    }
    
    private func getRefreshButton() -> some View {
        Button(
            action: vm.getSingleImage,
            label: {
                Text("Get Image")
            })
    }
}

struct VoteView_Previews: PreviewProvider {
    static var previews: some View {
        VoteView()
    }
}
