//
//  Presentation.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 20/03/2021.
//

import Foundation

class ProductsViewModel {
    
    private var allProducts: [Product]?
    
    var filteredDidChange: (() -> Void)?
    private var filteredProducts: [Product]? {
        didSet {
            filteredDidChange?()
        }
    }
    
    var searchText: String = "" {
        didSet {
            updateFilteredProducts()
        }
    }
    
    func getFilteredProducts() -> [Product]? {
        return filteredProducts
    }
    
    init() {
        
    }
    
    func viewDidLoad() {
        let getProductsRequest = GetProductsRequest()
        getProductsRequest.getProducts(complete: {
            [weak self] result in
            switch result {
            case .success(let products):
                self?.allProducts = products
                self?.filteredProducts = products
            case .failure(let networkError):
                print(networkError)
            }
        })
    }
    
    private func updateFilteredProducts() {
        
        let searchText = self.searchText.lowercased()
        
        if searchText == "" {
            filteredProducts = allProducts
        } else {
            let filteredProducts = allProducts?.filter({
            product -> Bool in
                return product.name.lowercased().contains(searchText) || product.description.lowercased().contains(searchText)
            })
            self.filteredProducts = filteredProducts
        }
        
        
    }
}