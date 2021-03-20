//
//  ProductCellViewModel.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 20/03/2021.
//

import Foundation

class ProductCellViewModel {
    let productName: String
    let productDescription: String
    let productPrice: String
    private let productImageUrl: String
    private var imageData: Data?
    
    init(product: Product) {
        productName = product.name
        productDescription = product.description
        productPrice = "\(product.currency) \(product.price)"
        productImageUrl = product.imageUrlString
    }
    
    func getProductImage(complete: @escaping (_ imageData: Data?) -> Void) {
        if let imageData = self.imageData {
            complete(imageData)
        } else {
            URLSession.shared.dataTask(with: URL(string: productImageUrl)!, completionHandler: {
                [weak self] data, _, _ in
                self?.imageData = data
                complete(data)
            }).resume()
        }
    }
}
