//
//  ViewControllerViewModel.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 22/03/2021.
//

import Foundation

class ViewControllerViewModel {
    var showNetworkError: ((_ networkError: NetworkError, _ onRetry: @escaping () -> Void) -> Void)?
}
