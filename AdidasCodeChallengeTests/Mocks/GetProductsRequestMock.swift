//
//  GetProductsRequestMock.swift
//  AdidasCodeChallengeTests
//
//  Created by Omar Ali on 22/03/2021.
//

@testable import AdidasCodeChallenge

class GetProductsRequestMock: GetProductsRequest {
    
    init() {
        super.init(reachabilityDeterminator: ReachabilityDeterminator.shared)
    }
    
    var didCallGetProducts: (() -> Void)?
    var getProductsResult: Result<[Product], NetworkError> = .failure(.noInternetConnection)
    override func getProducts(complete: @escaping (Result<[Product], NetworkError>) -> Void) {
        didCallGetProducts?()
        complete(getProductsResult)
    }
    
}
