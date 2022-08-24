//
//  BreedView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import SwiftUI

struct BreedView: View {
    @ObservedObject private var vm = BreedViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    ForEach(getAlphabets(), id:\.self) { alphabet in
                        Section(
                            content: {
                                getNavigationLinkList(alphabet)
                            },
                            header: {
                                Text(alphabet)
                            })
                    }
                }
                Spacer(minLength: 0)
                SearchBar($searchText)
            }
            .navigationBarHidden(true)
        }
        .onAppear(perform: loadBreeds)
    }
    
    private func loadBreeds() {
        vm.loadBreedModelsIfExists()
    }
    
    private func getNavigationLinkList(_ alphabet: String) -> some View {
        let filteredBreed = getFilteredBreed()
            .filter { getFirstCharacter($0.breedName) == alphabet }
        return ForEach(filteredBreed) { breed in
            NavigationLink(
                destination: {
                    BreedDetailView(breed: breed)
                        .navigationBarHidden(true)
                },
                label: {
                    Text(breed.breedName)
                })
        }
    }
    
    private func getNavigationLinkList() -> some View {
        ForEach(getFilteredBreed()) { breed in
            NavigationLink(
                destination: {
                    BreedDetailView(breed: breed)
                },
                label: {
                    Text(breed.breedName)
                })
        }
    }
    
    private func getFilteredBreed() -> [BreedModel] {
        return searchText.isEmpty ?
        vm.breeds :
        vm.breeds.filter { $0.breedName.contains(searchText) }
    }
    
    private func getAlphabets() -> [String] {
        let alphabets = getFilteredBreed()
            .map(\.breedName)
            .map { getFirstCharacter($0) }
        return Set(alphabets).sorted()
    }
    
    private func getFirstCharacter(_ string: String) -> String {
        guard let firstCharacter = string.first else {
            return ""
        }
        return String(firstCharacter)
    }
}

struct BreedView_Previews: PreviewProvider {
    static var previews: some View {
        BreedView()
    }
}
