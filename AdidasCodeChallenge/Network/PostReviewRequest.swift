//
//  PostReviewRequest.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 22/03/2021.
//

import Foundation

class PostReviewRequest {
    
    func postReview(review: Review, complete: @escaping (_ error: NetworkError?) -> Void) {
        
        guard let url = URL(string: "http://localhost:3002/reviews/\(review.productId)") else { return }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let jsonEncoder = JSONEncoder()
            try request.httpBody = jsonEncoder.encode(review)
            URLSession.shared.dataTask(with: request, completionHandler: {
                data, urlResponse, error in
                
                guard let httpUrlResponse = urlResponse as? HTTPURLResponse, error == nil  else {
                    complete(.noInternetConnection)
                    return
                }
                
                let statusCode = httpUrlResponse.statusCode
                if statusCode > 399 {
                    complete(.apiError(statusCode: statusCode))
                } else {
                    complete(nil)
                }
            }).resume()
        } catch {
            complete(.encodingError)
        }
    }
    
}
