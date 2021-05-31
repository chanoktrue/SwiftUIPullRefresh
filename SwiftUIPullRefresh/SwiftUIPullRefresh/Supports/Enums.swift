//
//  Enums.swift
//  SwiftUIPullRefresh
//
//  Created by Thongchai Subsaidee on 31/5/2564 BE.
//

import SwiftUI

enum NetworkError: Error {
    case invalidData
    case custom(errorMessage: String)
}


enum HttpMethod: String {
    case get, post, put, delete
}
