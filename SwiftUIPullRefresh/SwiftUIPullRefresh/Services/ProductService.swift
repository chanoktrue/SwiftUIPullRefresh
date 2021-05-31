//
//  ProductService.swift
//  SwiftUIPullRefresh
//
//  Created by Thongchai Subsaidee on 31/5/2564 BE.
//

import SwiftUI

struct ProductService {
    
    func getAPI(completion: @escaping (Result<[ProductModel], NetworkError>)->()) {
        
        let urlString = "http://homenano.trueddns.com:24349/api/posts"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.custom(errorMessage: "URL is not valide")))
            return
        }
 
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let json = try? JSONDecoder().decode([ProductModel].self, from: data) else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(json))
        }
        
        task.resume()
        
        
    }
    
}
