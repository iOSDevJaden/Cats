//
//  SettingsView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var picker: SettingsType = .user
    @ObservedObject private var vm = SettingsViewModel()
    
    var body: some View {
        VStack {
            Picker("", selection: $picker) {
                Text("User").tag(SettingsType.user)
                Text("Image").tag(SettingsType.image)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.vertical, 10)
            VStack {
                switch picker {
                case .user: UserForm().environmentObject(vm)
                case .image: Spacer()
                }
            }
        }
    }
    
    enum SettingsType: String, Identifiable {
        case user, image
        
        var id: String {
            self.rawValue
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
