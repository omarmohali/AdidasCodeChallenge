//
//  ProductsViewModelTests.swift
//  AdidasCodeChallengeTests
//
//  Created by Omar Ali on 22/03/2021.
//

import Foundation
import XCTest
@testable import AdidasCodeChallenge

class ProductsViewModelTests: XCTestCase {
    
    var getProductsRequest: GetProductsRequestMock!
    var productsViewModel: ProductsViewModel!
    
    override func setUp() {
        super.setUp()
        getProductsRequest = GetProductsRequestMock()
        productsViewModel = ProductsViewModel(getProductsRequest: getProductsRequest)
    }
    
    func testViewDidAppearWithAPISuccess() {
        
        let dummyProducts = [
            Product(id: "id1", name: "name1", description: "description1", imageUrlString: "url1", price: 50, currency: "EUR", reviews: []),
            Product(id: "id2", name: "name2", description: "description2", imageUrlString: "url2", price: 100, currency: "USD", reviews: []),
            Product(id: "id1", name: "name3", description: "description1", imageUrlString: "url3", price: 200, currency: "EGP", reviews: [])
        ]
        
        getProductsRequest.getProductsResult = .success(dummyProducts)
        
        let didCallGetProductsExpectation = XCTestExpectation()
        getProductsRequest.didCallGetProducts = {
            didCallGetProductsExpectation.fulfill()
        }
        
        productsViewModel.viewDidAppear()
        
        wait(for: [didCallGetProductsExpectation], timeout: 0)
        XCTAssertEqual(productsViewModel.getFilteredProducts(), dummyProducts)
    }
    
    
    func testViewDidAppearWithAPIFailure() {
        let dummyNetworkError = NetworkError.decodingError
        
        getProductsRequest.getProductsResult = .failure(dummyNetworkError)
        
        
        let didCallGetProductsExpectation = XCTestExpectation()
        getProductsRequest.didCallGetProducts = {
            didCallGetProductsExpectation.fulfill()
        }
        
        let didCallShowNetworkError = XCTestExpectation()
        productsViewModel.showNetworkError = {
            networkError, _ in
            didCallShowNetworkError.fulfill()
            XCTAssertEqual(networkError, dummyNetworkError)
        }
        
        productsViewModel.viewDidAppear()
        
        wait(for: [didCallGetProductsExpectation, didCallShowNetworkError], timeout: 0, enforceOrder: true)
        XCTAssertEqual(productsViewModel.getFilteredProducts(), nil)
    }
    
    func testViewDidAppearWithAPIFailureAndRetryWithSuccess() {
        
        let dummyProducts = [
            Product(id: "id1", name: "name1", description: "description1", imageUrlString: "url1", price: 50, currency: "EUR", reviews: []),
            Product(id: "id2", name: "name2", description: "description2", imageUrlString: "url2", price: 100, currency: "USD", reviews: []),
            Product(id: "id1", name: "name3", description: "description1", imageUrlString: "url3", price: 200, currency: "EGP", reviews: [])
        ]
        
        
        
        let dummyNetworkError = NetworkError.decodingError
        
        getProductsRequest.getProductsResult = .failure(dummyNetworkError)
        
        
        let didCallGetProductsExpectation = XCTestExpectation()
        didCallGetProductsExpectation.expectedFulfillmentCount = 2
        getProductsRequest.didCallGetProducts = {
            didCallGetProductsExpectation.fulfill()
        }
        
        let didCallShowNetworkError = XCTestExpectation()
        productsViewModel.showNetworkError = {
            networkError, onRetry in
            didCallShowNetworkError.fulfill()
            self.getProductsRequest.getProductsResult = .success(dummyProducts)
            onRetry()
        }
        
        productsViewModel.viewDidAppear()
        
        wait(for: [didCallGetProductsExpectation, didCallShowNetworkError], timeout: 0)
        XCTAssertEqual(productsViewModel.getFilteredProducts(), dummyProducts)
    }
    
    
    func testFilterProductsBySearch() {
        
        let productOneNotInSecondResults = Product(id: "id", name: "some dummy identifier", description: "some dummy description", imageUrlString: "", price: 50, currency: "EUR", reviews: [])
        let productTwoInFirstResults = Product(id: "id", name: "some dummy name with key", description: "some dummy description", imageUrlString: "", price: 50, currency: "EUR", reviews: [])
        let productThreeNotInResults = Product(id: "id", name: "some dummy name not in result", description: "some dummy description", imageUrlString: "", price: 50, currency: "EUR", reviews: [])
        let productFourInFirstResults = Product(id: "id", name: "some dummy name not in result", description: "some dummy description with key", imageUrlString: "", price: 50, currency: "EUR", reviews: [])
        let dummyAllProducts = [
            productOneNotInSecondResults,
            productTwoInFirstResults,
            productThreeNotInResults,
            productFourInFirstResults
        ]
        
        getProductsRequest.getProductsResult = .success(dummyAllProducts)
        
        let didCallGetProductsExpectation = XCTestExpectation()
        getProductsRequest.didCallGetProducts = {
            didCallGetProductsExpectation.fulfill()
        }
        
        productsViewModel.viewDidAppear()
        
        wait(for: [didCallGetProductsExpectation], timeout: 0)
        XCTAssertEqual(productsViewModel.getFilteredProducts(), dummyAllProducts)
        
        productsViewModel.searchText = "key"
        XCTAssertEqual(productsViewModel.getFilteredProducts(), [productTwoInFirstResults, productFourInFirstResults])
        productsViewModel.searchText = ""
        XCTAssertEqual(productsViewModel.getFilteredProducts(), dummyAllProducts)
        productsViewModel.searchText = "identifier"
        XCTAssertEqual(productsViewModel.getFilteredProducts(), [productOneNotInSecondResults])
        productsViewModel.searchText = "This is not in any product"
        XCTAssertEqual(productsViewModel.getFilteredProducts(), [])
        productsViewModel.searchText = ""
        XCTAssertEqual(productsViewModel.getFilteredProducts(), dummyAllProducts)
        
    }
    
}
