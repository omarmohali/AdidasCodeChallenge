//
//  GetProductsRequest.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 20/03/2021.
//

import Foundation

class GetProductsRequest: HttpRequest<String, [Product]> {
    
    override var method: String {
        return "GET"
    }
    
    override var urlString: String {
        return "\(ServiceUrls.productsServiceUrl)product"
    }
    
    func getProducts(complete: @escaping (Result<[Product], NetworkError>) -> Void) {
        execute(body: nil, complete: complete)
    }
}
