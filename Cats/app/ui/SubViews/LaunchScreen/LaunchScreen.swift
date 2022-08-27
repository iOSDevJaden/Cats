//
//  LaunchScreen.swift
//  Cats
//
//  Created by 김태호 on 2022/08/27.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack {
            Color.accentColor
            Image("cat-paw")
                .resizable()
                .scaledToFit()
        }
        .ignoresSafeArea()
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
