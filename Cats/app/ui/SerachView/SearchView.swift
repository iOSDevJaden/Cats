//
//  SearchView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import SwiftUI

struct SearchView: View, ImageViewProtocol {
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
        .onAppear(perform: vm.getSingleImage)
        .navigationTitle("Search Image")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
