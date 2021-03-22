//
//  ViewController.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 22/03/2021.
//

import UIKit

class ViewController<ViewModelType: ViewControllerViewModel>: UIViewController {
    
    let viewModel: ViewModelType
    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.showNetworkError = {
            [weak self] networkError, onRetry in
            DispatchQueue.main.async {
                self?.showNetworkError(error: networkError, onRetry: onRetry)
            }
        }
    }
    
    func showNetworkError(error: NetworkError, onRetry: (() -> Void)?) {
        
        let message: String
        switch error {
        case .encodingError, .decodingError, .apiError( _):
            message = "Something went wrong with our servers. Please try connecting later"
        case .noInternetConnection:
            message = "Please check your internet connection"
        }
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default, handler: {
            _ in
            onRetry?()
        })
        
        alert.addAction(retryAction)
        present(alert, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
