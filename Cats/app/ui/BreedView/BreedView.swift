//
//  BreedView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import SwiftUI

struct BreedView: View {
    @ObservedObject private var vm = BreedViewModel()
    @State private var dictionaryBreeds: [String: [Breed]] = [:]
    
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
                getProgressView()
            } else {
                getAlphabeticallyOrderedList()
            }
        }
    }
    
    private func getProgressView() -> some View {
        VStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
    
    private func getAlphabeticallyOrderedList() -> some View {
        List {
            ForEach(vm.categorizedBreeds.keys.sorted(), id: \.self) { key in
                Section(
                    content: {
                        ForEach(vm.categorizedBreeds[key]!) { breed in
                            NavigationLink(breed.name) {
                                BreedDetailView(breed: breed)
                                    .navigationBarHidden(true)
                            }
                        }
                    },
                    header: {
                        Text(key)
                    })
            }
        }
    }
}

struct BreedView_Previews: PreviewProvider {
    static var previews: some View {
        BreedView()
    }
}
