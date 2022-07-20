//
//  TabBarItems.swift
//  Cats
//
//  Created by 김태호 on 2022/07/13.
//

import SwiftUI

protocol TabItemProtocol: Identifiable, CaseIterable { }

enum TabBarItems: String, TabItemProtocol {
    /**
     * New Version
     * 1. Home - show images that user voteup-ed and favourited.
     * 2. Search - show random images that user can like or favourite it
     * 3. Upload Images (sheet)
     * 4. Breeds
     * 5. Profile - User Settings
     */
    case home,
         search,
         upload,
         breeds,
         profile
    
    var id: String {
        UUID().uuidString
    }
    
    var labelText: String {
        self.rawValue.capitalized
    }
    
    private func getLabelIcon() -> some View {
        VStack {
            switch self {
            case .home:    Image(systemName: "house.circle").setTabItemModifier()
            case .search:  Image(systemName: "magnifyingglass.circle").setTabItemModifier()
            case .upload:  Image(systemName: "plus.app").setTabItemModifier()
            case .breeds:  Image(systemName: "book.circle").setTabItemModifier()
            case .profile: Image(systemName: "person.crop.circle").setTabItemModifier()
            }
        }
    }
    
    private func getLabelCaption() -> some View {
        switch self {
        case .home:    return Text(labelText).modifier(IconCaptionModifier())
        case .search:  return Text(labelText).modifier(IconCaptionModifier())
        case .upload:  return Text(labelText).modifier(IconCaptionModifier())
        case .breeds:  return Text(labelText).modifier(IconCaptionModifier())
        case .profile: return Text(labelText).modifier(IconCaptionModifier())
        }
    }
    
    func getLabel() -> some View {
        VStack {
            switch self {
            case .home:
                self.getLabelIcon()
                self.getLabelCaption()
            case .search:
                self.getLabelIcon()
                self.getLabelCaption()
            case .upload:
                self.getLabelIcon()
                self.getLabelCaption()
            case .breeds:
                self.getLabelIcon()
                self.getLabelCaption()
            case .profile:
                self.getLabelIcon()
                self.getLabelCaption()
            }
        }
    }
    
    func getButtons(action: @escaping () -> ()) -> some View {
        switch self {
        case .home:    return Button(action: action, label: getLabel)
        case .search:  return Button(action: action, label: getLabel)
        case .upload:  return Button(action: action, label: getLabel)
        case .breeds:  return Button(action: action, label: getLabel)
        case .profile: return Button(action: action, label: getLabel)
        }
    }
}

fileprivate struct IconCaptionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.caption)
    }
}

extension Image {
    fileprivate func setTabItemModifier() -> some View {
        self.resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
    }
}

struct TabItems_Preview: PreviewProvider {
    @State static var tab = TabBarItems.home
    
    static var previews: some View {
        Group {
            HStack(spacing: 30) {
                ForEach(TabBarItems.allCases) { item in
                    item.getButtons(action: { self.tab = item })
                        .foregroundColor(item == tab ? .black : .purple)
                }
            }
            .foregroundColor(.purple)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
