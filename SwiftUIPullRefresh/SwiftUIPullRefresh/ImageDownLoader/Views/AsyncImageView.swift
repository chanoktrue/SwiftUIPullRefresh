//
//  AsyncImageView.swift
//  SwiftUIPullRefresh
//
//  Created by Thongchai Subsaidee on 31/5/2564 BE.
//

import SwiftUI

struct AsyncImageView: View {
    @ObservedObject private var downloader: ImageDownloader
    
    private var image: some View {
        Group {
            if downloader.image != nil {
                Image(uiImage: downloader.image!)
                    .resizable()
            }else {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    init(url: URL) {
        downloader = ImageDownloader(url: url)
    }
    
    var body: some View {
        image
            .onAppear{
                downloader.start()
            }
            .onDisappear{
                downloader.stop()
            }
    }
    
}
