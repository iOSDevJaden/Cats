//
//  CameraView.swift
//  Cats
//
//  Created by 김태호 on 2022/08/03.
//

import SwiftUI

struct CameraView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Caemra")
            Button(action: dismiss, label: {
                Text("Dismiss View")
            })
        }
        
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
