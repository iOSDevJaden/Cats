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
            getBreedList(vm.breeds)
        }
        .onAppear(perform: vm.getAllBreeds)
    }
    
    private func getBreedList(_ breeds: [Breed]) -> some View {
        VStack {
            if(breeds.isEmpty) {
                ProgressView()
                Spacer()
            } else {
                List {
                    ForEach(vm.breeds) { breed in
                        Text(breed.name)
                    }
                }
            }
        }
    }
}

struct BreedView_Previews: PreviewProvider {
    static var previews: some View {
        BreedView()
    }
}
