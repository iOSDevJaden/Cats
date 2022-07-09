//
//  BreedView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import SwiftUI

struct BreedView: View {
    @ObservedObject private var vm = BreedViewModel()
    
    var body: some View {
        VStack {
            Text("Breeds")
                .font(.title)
            List {
                ForEach(vm.breeds) { breed in
                    Text(breed.name)
                }
            }
        }
       .onAppear(perform: vm.getAllBreeds)
    }
}

struct BreedView_Previews: PreviewProvider {
    static var previews: some View {
        BreedView()
    }
}
