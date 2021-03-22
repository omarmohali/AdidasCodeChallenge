//
//  PostReviewRequest.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 22/03/2021.
//

import Foundation

class PostReviewRequest: HttpRequest<Review, Review> {
    
    override var urlString: String {
        return "http://localhost:3002/reviews/\(productId)"
    }
    
    override var method: String {
        return "POST"
    }
    
    
    
    private let productId: String
    init(productId: String, reachabilityDeterminator: ReachabilityDeterminator) {
        self.productId = productId
        super.init(reachabilityDeterminator: reachabilityDeterminator)
    }
    
    convenience init(productId: String) {
        self.init(productId: productId, reachabilityDeterminator: ReachabilityDeterminator.shared)
    }
    
    func postReview(review: Review, complete: @escaping (_ error: NetworkError?) -> Void) {
        execute(body: review, complete: {
            result in
            switch result {
            case .success( _):
                complete(nil)
            case .failure(let networkError):
                complete(networkError)
            }
        })

    }
    
}
