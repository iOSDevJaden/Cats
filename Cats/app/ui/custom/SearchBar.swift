//
//  SearchBar.swift
//  Cats
//
//  Created by 김태호 on 2022/07/13.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var searchText: String
    
    init(_ searchText: Binding<String>) {
        _searchText = searchText
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .infinite)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .prominent
        searchBar.isTranslucent = true
        return searchBar
    }
    
    func updateUIView(
        _ uiView: UISearchBar,
        context: UIViewRepresentableContext<SearchBar>
    ) {
        uiView.text = self.searchText
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator($searchText)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var searchText: String
        
        init(_ searchText: Binding<String>) {
            _searchText = searchText
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.searchText = searchText
        }
    }
}

struct SearchBar_Preview: PreviewProvider {
    static var previews: some View {
        SearchBar(.constant("Search Bar"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
