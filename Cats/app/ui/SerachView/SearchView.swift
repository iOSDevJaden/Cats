//
//  SearchView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var vm = SearchViewModel()
    
    var body: some View {
        VStack {
            Text("Image")
                .font(.title)
            List {
                ForEach(vm.images) { image in
                    if let image = getImage(imageUrl: image.url) {
                        image.resizable()
                    }
                }
            }
        }
        .onAppear(perform: vm.getAllPublicImages)
    }
    
    private func getImage(imageUrl: String?) -> Image? {
        guard let imageUrl = imageUrl,
              let imageUrl = URL(string: imageUrl),
              let imageData = try? Data(contentsOf: imageUrl),
              let uiImage = UIImage(data: imageData) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
