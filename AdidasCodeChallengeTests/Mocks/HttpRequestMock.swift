//
//  HttpRequestMock.swift
//  AdidasCodeChallengeTests
//
//  Created by Omar Ali on 22/03/2021.
//

@testable import AdidasCodeChallenge

class HttpRequestMock<BodyType: Encodable, ResponseType: Decodable>: HttpRequest<BodyType, ResponseType> {
    
    var didCallExecute: ((BodyType?) -> Void)?
    var executeResult: Result<ResponseType, NetworkError> = .failure(.noInternetConnection)
    override func execute(body: BodyType?, complete: @escaping (Result<ResponseType, NetworkError>) -> Void) {
        didCallExecute?(body)
        complete(executeResult)
    }
    
}

