//
//  SearchView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var vm = SearchViewModel()
    
    let colums: [GridItem] = [
        GridItem(.flexible(minimum:60), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: colums, spacing: nil) {
                ForEach(vm.images) { image in
                    if let url = image.url {
                        AsyncImgView(url)
                            .frame(height: 120, alignment: .top)
                    }
                }
            }
        }
        .onAppear(perform: vm.getSingleImage)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
