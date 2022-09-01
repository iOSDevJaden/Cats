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
    private let placeHolder = Image("cat-paw")
    @ObservedObject private var vm: AsyncImgViewModel
    @State private var uiImage: UIImage? = nil
    
    init(_ urlString: String) {
        self.urlString = urlString
        vm = AsyncImgViewModel(urlString)
    }
    
    var body: some View {
        VStack {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                placeHolder
                    .resizable()
                    .scaledToFit()
            }
        }
        .onReceive(vm.$imageData) { data in
            guard let data = data,
                  let uiImage = UIImage(data: data) else {
                return
            }
            self.uiImage = uiImage
        }
    }
}

struct AsyncImgView_Previews: PreviewProvider {
    // Example Strings
    static let imgUrlString1 = "https://24.media.tumblr.com/tumblr_lr8ywvqLEr1qz4dkmo1_250.jpg"
    static let imgUrlString2 = "https://25.media.tumblr.com/tumblr_lgruxcE8vY1qgnva2o1_250.jpg"
    static let imgUrlString3 = "https://cdn2.thecatapi.com/images/O_GNlmO7K.jpg"
    
    static var previews: some View {
        Group {
            VStack {
                AsyncImgView(imgUrlString1)
                AsyncImgView(imgUrlString2)
                AsyncImgView(imgUrlString3)
            }
        }
    }
}
