//
//  ProductViewModelTests.swift
//  AdidasCodeChallengeTests
//
//  Created by Omar Ali on 22/03/2021.
//

import Foundation
import XCTest
@testable import AdidasCodeChallenge

class ProductViewModelTests: XCTestCase {
    
    var postReviewRequest: PostReviewRequestMock!
    var productViewModel: ProductViewModel!
    
    var dummyProduct: Product {
        return Product(id: "id", name: "name", description: "description", imageUrlString: "url", price: 100, currency: "EUR", reviews: [
            Review(productId: "id", locale: "en-US", rating: 3, text: "Average product"),
            Review(productId: "id", locale: "en-US", rating: 5, text: "Excellent product"),
            Review(productId: "id", locale: "en-US", rating: 1, text: "Poor product"),
            Review(productId: "id", locale: "en-US", rating: 4, text: "Good product")
        ])
    }
    
    override func setUp() {
        super.setUp()
        postReviewRequest = PostReviewRequestMock(productId: "id")
        productViewModel = ProductViewModel(product: dummyProduct)
        productViewModel.postReviewRequest = postReviewRequest
    }

    func testGetProduct() {
        XCTAssertEqual(productViewModel.getProduct(), dummyProduct)
    }
    
    func testDidPostReviewWithAPISuccess() {
        
        let dummyReview = Review(productId: "id", locale: "en-US", rating: 2, text: "I did not like the product")
        
        postReviewRequest.postReviewResult = .noInternetConnection
        
        let didCallPostReviewExpectation = XCTestExpectation()
        postReviewRequest.didCallPostReview = {
            review in
            didCallPostReviewExpectation.fulfill()
            XCTAssertEqual(review, dummyReview)
        }
        
        let didCallShowNetworkError = XCTestExpectation()
        productViewModel.showNetworkError = {
            networkError, _ in
            didCallShowNetworkError.fulfill()
        }
        
        productViewModel.didPostReview(rating: 2, reviewText: "I did not like the product")
        
        wait(for: [didCallPostReviewExpectation, didCallShowNetworkError], timeout: 0)
        XCTAssertEqual(productViewModel.getProduct(), dummyProduct)
        
    }
    
    func testDidPostReviewWithAPIFailure() {
        
        let dummyReview = Review(productId: "id", locale: "en-US", rating: 4, text: "I liked the product")
        
        let didCallPostReviewExpectation = XCTestExpectation()
        postReviewRequest.didCallPostReview = {
            review in
            didCallPostReviewExpectation.fulfill()
            XCTAssertEqual(review, dummyReview)
        }
        
        productViewModel.didPostReview(rating: 4, reviewText: "I liked the product")
        
        wait(for: [didCallPostReviewExpectation], timeout: 0)
        XCTAssertEqual(productViewModel.getProduct().reviews.count, dummyProduct.reviews.count + 1)
        
    }
    
}
