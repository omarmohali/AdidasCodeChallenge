//
//  NetworkError.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 22/03/2021.
//

import Foundation

enum NetworkError: Error {
    case noInternetConnection
    case apiError(statusCode: Int)
    case decodingError
    case encodingError
}
