//
//  GetProductsRequest.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 20/03/2021.
//

import Foundation

class GetProductsRequest {
    
    func getProducts(complete: @escaping (Result<[Product], NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: URL(string: "http://localhost:3001/product")!, completionHandler: {
            data, urlResponse, error in
            
            guard let httpUrlResponse = urlResponse as? HTTPURLResponse, let data = data, error == nil  else {
                complete(.failure(.noInternetConnection))
                return
            }
            
            let statusCode = httpUrlResponse.statusCode
            if statusCode > 399 {
                complete(.failure(.apiError(statusCode: statusCode)))
            } else {
                do {
                    let jsonDecoder = JSONDecoder()
                    let products = try jsonDecoder.decode([Product].self, from: data)
                    complete(.success(products))
                } catch {
                    complete(.failure(.decodingError))
                }
                
            }
        }).resume()
        
    }
    
}



enum NetworkError: Error {
    case noInternetConnection
    case apiError(statusCode: Int)
    case decodingError
}
