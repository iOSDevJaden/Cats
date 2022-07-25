//
//  SettingsView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/25.
//

import SwiftUI

struct SettingsView: View {
    @State var picker: SettingsType = .user
    var body: some View {
        VStack {
            Picker("", selection: $picker) {
                Text("User").tag(SettingsType.user)
                Text("Image").tag(SettingsType.image)
            }
            .pickerStyle(.segmented)
            VStack {
                switch picker {
                case .user: UserForm()
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

struct UserForm: View {
    @State var edit = false
    @State var page: Float = 0
    @State var numberOfPic: Float = 0
    
    var body: some View {
        Form {
            Section(
                content: {
                    ProfileView()
                },
                header: {
                    Text("User Profile")
                })
            Section(
                content: {
                    Text("edit text")
                },
                header: {
                    Toggle(isOn: $edit, label: { Text("edit") })
                })
            Section(
                content: {
                    Text("Page at \(String(format: "%d", Int(page)))")
                    Slider(value: $page, in: 0...10)
                },
                header: {
                    Text("Page")
                })
            Section(
                content: {
                    Text("Show Pictures in a page (\(String(format: "%d", Int(numberOfPic))))")
                    Slider(value: $numberOfPic, in: 15...30)
                },
                header: {
                    Text("Number of pictures")
                })
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
