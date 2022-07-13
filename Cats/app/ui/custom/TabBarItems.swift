//
//  TabBarItems.swift
//  Cats
//
//  Created by 김태호 on 2022/07/13.
//

import SwiftUI

protocol TabItemProtocol: Identifiable, CaseIterable { }

enum TabBarItems: String, TabItemProtocol {
    case vote,
         breed,
         favourite,
         search,
         upload
    
    var id: String {
        UUID().uuidString
    }
    
    var text: String {
        self.rawValue.capitalized
    }
    
    private var iconName: String {
        switch self {
        case .vote:      return "archivebox"
        case .breed:     return "sun.min"
        case .search:    return "magnifyingglass"
        case .favourite: return "heart"
        case .upload:    return "arrow.up.bin"
        }
    }
    
    private func getTabItemLable() -> some View {
        VStack {
            getTabItemImage()
            getTabItemText()
        }
    }
    
    private func getTabItemText() -> Text {
        switch self {
        case .vote:      return Text(text).font(.caption)
        case .breed:     return Text(text).font(.caption)
        case .favourite: return Text(text).font(.caption)
        case .search:    return Text(text).font(.caption)
        case .upload:    return Text(text).font(.caption)
        }
    }
    
    private func getTabItemImage() -> some View {
        switch self {
        case .vote:      return
            Image(systemName: self.iconName)
                .resizable()
                .frame(width: 25, height: 25)
        case .breed:     return
            Image(systemName: self.iconName)
                .resizable()
                .frame(width: 25, height: 25)
        case .favourite: return
            Image(systemName: self.iconName)
                .resizable()
                .frame(width: 25, height: 25)
        case .search:    return
            Image(systemName: self.iconName)
                .resizable()
                .frame(width: 25, height: 25)
        case .upload:    return
            Image(systemName: self.iconName)
                .resizable()
                .frame(width: 25, height: 25)
        }
    }
    
    func getTabItemButtons(action: @escaping () -> ()) -> some View {
        switch self {
        case .vote:      return Button(action: action, label: getTabItemLable)
        case .breed:     return Button(action: action, label: getTabItemLable)
        case .favourite: return Button(action: action, label: getTabItemLable)
        case .search:    return Button(action: action, label: getTabItemLable)
        case .upload:    return Button(action: action, label: getTabItemLable)
        }
    }
    
}
