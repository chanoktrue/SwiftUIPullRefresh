//
//  ProductViewModel.swift
//  SwiftUIPullRefresh
//
//  Created by Thongchai Subsaidee on 31/5/2564 BE.
//

import SwiftUI

class ProductViewModel: ObservableObject {
    
    @Published var products = [ProductModel]()
    
    func getData() {
        ProductService().getAPI { result in
            switch result {
            case .success(let products):
            DispatchQueue.main.async {
                self.products = products
            }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

