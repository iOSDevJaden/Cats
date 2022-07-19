//
//  AsyncImgViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/19.
//

import Combine
import Foundation

class AsyncImgViewModel: ObservableObject {
    
    private let urlString: String
    private var cancellable = Set<AnyCancellable>()
    
    @Published var imageData = Data()
    
    init(_ urlString: String) {
        self.urlString = urlString
        self.getDataFrom(url: urlString)
    }
    
    func getDataFrom(url: String) {
        guard let url = URL(string: url) else {
            print("Error URL \(URLError.badURL)")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .sink(
                receiveCompletion: {
                    print("Receive Completion \($0)")
                },
                receiveValue: { [weak self] data in
                    self?.imageData = data
                })
            .store(in: &cancellable)
    }
}
