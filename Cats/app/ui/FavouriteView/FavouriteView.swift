//
//  FavouriteView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import SwiftUI

struct FavouriteView: View {
    @ObservedObject private var vm = FavouriteViewModel()
    
    var body: some View {
        List {
            ForEach(vm.favourites) { favourite in
                Text("\(favourite.id)")
                    .onTapGesture(perform: { vm.deleteFavourites(favouriteId: favourite.id) })
            }
        }
        .onAppear(perform: vm.getMyFavourites)
        
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
