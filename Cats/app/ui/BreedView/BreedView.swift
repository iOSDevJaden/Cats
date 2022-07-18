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
                if let breeds = vm.breeds {
                    getBreedList(breeds)
                } else {
                    getProgressView()
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear(perform: vm.getAllBreeds)
    }
    
    
    private func getBreedList(_ breeds: [Breed]) -> some View {
        let dict = getBreedDictionary(breeds)
        let keys = dict.keys.sorted()
        
        return List {
            ForEach(keys, id: \.self) { key in
                if let dict = dict[key] {
                    getSectionOfNames(with: key, breeds: dict)
                }
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
    
    private func getBreedDictionary(_ breeds: [Breed]) -> Dictionary<String, [Breed]> {
        let names = searchText.isEmpty ?
        breeds
            .map { $0.name } :
        breeds
            .filter { $0.name.contains(searchText) }
            .map { $0.name }
        
        let keys = Array(Set(names.map { $0.first })) // Remove duplication
        var dictionaryBreeds: [String: [Breed]] = [:]
        keys.forEach {
            if let key = $0 {
                dictionaryBreeds[String(key)] = breeds.filter { $0.name.contains(String(key)) }
            }
        }
        return dictionaryBreeds
    }
}

struct BreedView_Previews: PreviewProvider {
    static var previews: some View {
        BreedView()
    }
}
