//
//  UserForm.swift
//  Cats
//
//  Created by 김태호 on 2022/07/30.
//

import SwiftUI

struct UserForm: View {
    @EnvironmentObject var vm: SettingsViewModel
    @State var edit = false
    @State var numberOfPic: Float = 0
    
    var body: some View {
        Form {
            Section(
                content: {
                    ProfileView()
                        .environmentObject(vm)
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
                    Text("Page at \(Int(vm.currentPage))")
                    Slider(value: $vm.currentPage, in: 0...vm.getMaximumPage())
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

struct UserForm_Previews: PreviewProvider {
    static var previews: some View {
        UserForm()
    }
}
