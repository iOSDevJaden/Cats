//
//  VoteView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/08.
//

import SwiftUI

struct VoteView: View, ImageViewProtocol {
    @ObservedObject var vm = VoteViewModel()
    @State private var images: [Image] = []
    
    var body: some View {
        VStack {
            // Images
            Spacer()
            
            // Buttons
            Group {
                HStack {
                    VoteButton.like
                        .getButton(action: {})
                    VoteButton.favourite
                        .getButton(action: {})
                }
                .padding([.horizontal, .bottom])
            }
            
        }
        .onAppear(perform: vm.getAllImages)
        .onReceive(
            vm.$images,
            perform: { images in
                let imageUrls = images.compactMap { $0.url }
                imageUrls.forEach {
                    if let image = getImage(imageUrl: $0) {
                        self.images.append(image)
                    }
                }
            })
    }
}

extension VoteView {
    enum VoteButton {
        case favourite,
             like,
             unlike
        
        func getLable() -> some View {
            switch self {
            case .favourite: return Labels(text: "Favourite")
            case .like:      return Labels(text: "Like it")
            case .unlike:    return Labels(text: "Nope it")
            }
        }
        
        func getButton(action: @escaping () -> ()) -> some View {
            switch self {
            case .favourite: return Button(action: action, label: getLable)
            case .like:      return Button(action: action, label: getLable)
            case .unlike:    return Button(action: action, label: getLable)
            }
        }
    }
}

struct VoteView_Previews: PreviewProvider {
    static var previews: some View {
        VoteView()
    }
}
