//
//  AsyncImgView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/19.
//

import SwiftUI

/** MARK:
 * AsyncImageLoaderView is created to asynchronously get data from image url.
 * Previously used the following method. * Data(contentsOf: URL) *
 * Following Document says that the method works synchronously.
 * https://developer.apple.com/documentation/foundation/nsdata/1413892-init
 */

struct AsyncImgView: View {
    let urlString: String
    @ObservedObject private var vm: AsyncImgViewModel
    @State var uiImage = UIImage()
    
    init(_ urlString: String) {
        self.urlString = urlString
        vm = AsyncImgViewModel(urlString)
    }
    
    var body: some View {
        VStack {
            Image(uiImage: uiImage)
        }
        .onReceive(vm.$imageData) { data in
            guard let uiImage = UIImage(data: data) else {
                return
            }
            self.uiImage = uiImage
        }
    }
}

struct AsyncImgView_Previews: PreviewProvider {
    static let url1 = "https://24.media.tumblr.com/tumblr_lr8ywvqLEr1qz4dkmo1_250.jpg"
    static let url2 = "https://25.media.tumblr.com/tumblr_lgruxcE8vY1qgnva2o1_250.jpg"
    static let url3 = "https://cdn2.thecatapi.com/images/O_GNlmO7K.jpg"

    static var previews: some View {
        Group {
            VStack {
                AsyncImgView(url1)
                AsyncImgView(url2)
                AsyncImgView(url3)
            }
        }
    }
}
