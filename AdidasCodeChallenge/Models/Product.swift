//
//  Product.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 20/03/2021.
//

import Foundation

struct Product: Decodable, Equatable {
    let id: String
    let name: String
    let description: String
    let imageUrlString: String
    let price: Double
    let currency: String
    var reviews: [Review]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case imageUrlString = "imgUrl"
        case price = "price"
        case currency = "currency"
        case reviews = "reviews"
    }
}
