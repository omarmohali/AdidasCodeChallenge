//
//  ReviewCellViewModel.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 21/03/2021.
//

import Foundation

class ReviewCellViewModel {
    
    let ratingValue: String
    let reviewText: String
    
    init(review: Review) {
        self.ratingValue = "\(review.rating)/5"
        self.reviewText = review.text
    }
    
    
}
