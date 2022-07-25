//
//  ProfileView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .padding()
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.red, lineWidth: 5))

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Name")
                }
                HStack {
                    Text("Sub ID")
                }
            }
            .font(.title2)
            .padding(.leading)
            Spacer()
        }
        .frame(height: 80)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
