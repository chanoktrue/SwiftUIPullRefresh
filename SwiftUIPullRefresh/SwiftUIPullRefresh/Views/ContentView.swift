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
                    Text(product.post_image)
                }
            }
            .onAppear{
                productVM.getData()
            }
            .navigationTitle("Product")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
