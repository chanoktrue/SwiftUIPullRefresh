//
//  ProductModel.swift
//  SwiftUIPullRefresh
//
//  Created by Thongchai Subsaidee on 31/5/2564 BE.
//

import SwiftUI

struct ProductModel: Decodable, Hashable {
    let id: Int
    let post_image: String
    let post_category: String
    let post_name: String
    let post_detail: String
    let post_date: String
}
