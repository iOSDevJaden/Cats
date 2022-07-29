//
//  BreedDetailView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/13.
//

import SwiftUI

struct BreedDetailView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var showWiki = false
    let breed: BreedModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section(
                    content: {
                        HStack {
                            Text(breed.breedName)
                            Spacer()
                            Button(action: { showWiki = true }, label: {
                                Image(systemName: "questionmark.circle")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.blue)
                            })
                        }
                    },
                    header: {
                        Text("Breed Name")
                    })
                Section(
                    content: {
                        let temperatments = breed.breedTemperament.split(separator: ",")
                        ForEach(temperatments, id: \.self) { temperatment in
                            Text(temperatment)
                        }
                    },
                    header: {
                        Text("Temperament")
                    })
                Section(
                    content: {
                        Text(breed.breedOrigin)
                    },
                    header: {
                        Text("Origin")
                    })
                Section(
                    content: {
                        showRates(rate: breed.childFriendly)
                    },
                    header: {
                        Text("Child Friendly")
                    })
                Section(
                    content: {
                        showRates(rate: breed.dogFriendly)
                    },
                    header: {
                        Text("Dog Friendly")
                    })
                Section(
                    content: {
                        showRates(rate: breed.energyLevel)
                    },
                    header: {
                        Text("Energy Level")
                    })
                Section(
                    content: {
                        showRates(rate: breed.strangerFriendly)
                    },
                    header: {
                        Text("Stranger Friendly")
                    })
                Section(
                    content: {
                        showRates(rate: breed.socialNeeds)
                    },
                    header: {
                        Text("Social Needs")
                    })
            }
            .sheet(
                isPresented: $showWiki,
                content: {
                    if let wikiPedia = breed.wikipediaUrl {
                        CatWikiView(url: wikiPedia)
                    }
                })
            Button(
                action: dismiss,
                label: { Labels(text: "Dismiss") })
            .padding(.horizontal)
        }
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func showRates(rate: Int) -> some View {
        HStack {
            Spacer()
            ForEach(0 ..< 5) { index in
                Image(systemName: index >= rate ? "star" : "star.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(index >= rate ? .black : .yellow)
            }
            Spacer()
        }
    }
}


struct BreedDetailView_Previews: PreviewProvider {
    static let breed = BreedRes.staticBreed.mapToBreedModel()
    
    static var previews: some View {
        BreedDetailView(breed: breed)
    }
}
