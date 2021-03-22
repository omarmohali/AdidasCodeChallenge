//
//  ReachabilityDeterminatorMock.swift
//  AdidasCodeChallengeTests
//
//  Created by Omar Ali on 22/03/2021.
//

@testable import AdidasCodeChallenge

class ReachablilityDeterminatorMock: ReachabilityDeterminator {
    
    var isReachableResult = false
    override var isReachable: Bool {
        return isReachableResult
    }
    
}
