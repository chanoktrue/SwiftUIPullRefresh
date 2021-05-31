//
//  ContentView.swift
//  SwiftUIPullRefresh
//
//  Created by Thongchai Subsaidee on 31/5/2564 BE.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var productVM = ProductViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(productVM.products, id:\.self) { product in
                    AsyncImageView(url: URL(string: product.post_image)!)
                        .aspectRatio(contentMode: .fit)
                    
                    Text(product.post_name)
                }
            }
            .onAppear{
                productVM.getData()
            }
            .navigationTitle("Product \(productVM.products.count)")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
