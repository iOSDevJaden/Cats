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
        NavigationView {
            VStack {
                getBreedList(vm.breeds)
            }
            .navigationBarHidden(true)
        }
        .onAppear(perform: vm.getAllBreeds)
    }
    
    private func getBreedList(_ breeds: [Breed]) -> some View {
        VStack {
            if(breeds.isEmpty) {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                List {
                    ForEach(vm.breeds) { breed in
                        NavigationLink(breed.name) {
                            BreedDetailView(breed: breed)
                        }
                    }
                }
                .listStyle(.grouped)
            }
        }
    }
}

struct BreedView_Previews: PreviewProvider {
    static var previews: some View {
        BreedView()
    }
}
