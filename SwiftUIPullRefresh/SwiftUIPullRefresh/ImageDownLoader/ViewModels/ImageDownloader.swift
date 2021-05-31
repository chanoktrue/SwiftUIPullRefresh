//
//  ImageDownloader.swift
//  SwiftUIPullRefresh
//
//  Created by Thongchai Subsaidee on 31/5/2564 BE.
//

import SwiftUI
import Combine

class ImageDownloader: ObservableObject {
    @Published private(set) var image: UIImage?
    
    private let url: URL
    private var cancellable: AnyCancellable?
    
    init(url: URL) {
        self.url = url
    }
    
    func start() {
        cancellable = URLSession(configuration: .default)
            .dataTaskPublisher(for: url)
            .map{UIImage(data: $0.data)}
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func stop() {
        cancellable?.cancel()
    }
    
    deinit {
        cancellable?.cancel()
    }
    
}
