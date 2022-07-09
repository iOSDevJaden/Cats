//
//  VoteView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/08.
//

import SwiftUI

struct VoteView: View {
    @ObservedObject var vm = VoteViewModel()
    
    var body: some View {
        VStack {
            Text("Vote View")
        }
    }
    
    private func getImage(data: Data) -> Image? {
        guard let uiImage = UIImage(data: data) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
}

struct VoteView_Previews: PreviewProvider {
    static var previews: some View {
        VoteView()
    }
}
