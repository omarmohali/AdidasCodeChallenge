//
//  ProductViewModel.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 21/03/2021.
//

import Foundation

class ProductViewModel: ViewControllerViewModel {
    
    var postReviewRequest: PostReviewRequest
    
    var productDidChange: (() -> Void)?
    private var product: Product {
        didSet {
            productDidChange?()
        }
    }
    init(product: Product) {
        self.product = product
        postReviewRequest = PostReviewRequest(productId: product.id)
    }
    
    func getProduct() -> Product {
        return product
    }
    
    func didPostReview(rating: Int, reviewText: String) {
        let review = Review(productId: product.id, locale: "en-US", rating: rating, text: reviewText)
        postReviewRequest.postReview(review: review, complete: {
            [weak self] networkError in
            guard let self = self else { return }
            if let networkError = networkError {
                self.showNetworkError?(networkError,  {
                    self.didPostReview(rating: rating, reviewText: reviewText)
                })
            } else {
                self.product.reviews = [review] + self.product.reviews
            }
        })
    }
}
