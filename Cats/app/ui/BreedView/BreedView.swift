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
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar($searchText)
                Spacer(minLength: 0)
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
                if let breeds = vm.categorizedBreeds[key] {
                    getSectionOfNames(with: key, breeds: breeds)
                }
            }
        }
        .listStyle(.grouped)
    }
    
    private func getSectionOfNames(with key: String, breeds: [Breed]) -> some View {
        Section(
            content: {
                ForEach(breeds) { breed in
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

struct BreedView_Previews: PreviewProvider {
    static var previews: some View {
        BreedView()
    }
}
