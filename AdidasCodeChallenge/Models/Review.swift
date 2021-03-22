//
//  Review.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 20/03/2021.
//

import Foundation

struct Review: Codable {
    let productId: String
    let locale: String
    let rating: Int
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case productId
        case locale
        case rating
        case text
    }
}
