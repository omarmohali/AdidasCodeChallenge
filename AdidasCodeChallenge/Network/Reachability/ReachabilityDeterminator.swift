//
//  ReachabilityDeterminator.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 22/03/2021.
//

import Foundation
import Reachability

class ReachabilityDeterminator {
    
    static let shared: ReachabilityDeterminator = ReachabilityDeterminator()
    
    var isReachable: Bool {
    let reachability = try? Reachability()
        return reachability?.connection != .unavailable
    }
    
    
}
