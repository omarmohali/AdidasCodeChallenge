//
//  Presentation.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 20/03/2021.
//

import Foundation

class ProductsViewModel: ViewControllerViewModel {
    
    private var allProducts: [Product]?
    
    var filteredDidChange: (() -> Void)?
    private var filteredProducts: [Product]? {
        didSet {
            if let filteredProducts = filteredProducts {
                filteredProductsViewModels = filteredProducts.map({DisplayProductViewModel(product: $0)})
            }
        }
    }
    
    private var filteredProductsViewModels: [DisplayProductViewModel]? {
        didSet {
            filteredDidChange?()
        }
    }
    
    var searchText: String = "" {
        didSet {
            updateFilteredProducts()
        }
    }
    
    var getProductsRequest: GetProductsRequest
    init(getProductsRequest: GetProductsRequest) {
        self.getProductsRequest = getProductsRequest
        super.init()
    }
    
    func viewDidAppear() {
        getProducts()
    }
    
    private func getProducts() {
        getProductsRequest.getProducts(complete: {
            [weak self] result in
            switch result {
            case .success(let products):
                self?.allProducts = products
                self?.filteredProducts = products
            case .failure(let networkError):
                self?.showNetworkError?(networkError, {
                    self?.getProducts()
                })
            }
        })
    }
    
    func getFilteredProductsViewModels() -> [DisplayProductViewModel]? {
        return filteredProductsViewModels
    }
    
    func getFilteredProducts() -> [Product]? {
        return filteredProducts
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
