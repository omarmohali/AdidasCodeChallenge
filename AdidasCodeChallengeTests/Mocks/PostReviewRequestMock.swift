//
//  PostReviewMock.swift
//  AdidasCodeChallengeTests
//
//  Created by Omar Ali on 22/03/2021.
//

import Foundation
@testable import AdidasCodeChallenge

class PostReviewRequestMock: PostReviewRequest {
    
    var didCallPostReview: ((_ review: Review) -> Void)?
    var postReviewResult: NetworkError?
    override func postReview(review: Review, complete: @escaping (NetworkError?) -> Void) {
        didCallPostReview?(review)
        complete(postReviewResult)
    }
    
}
