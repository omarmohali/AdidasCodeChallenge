//
//  ProductHeaderView.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 21/03/2021.
//

import UIKit

class ProductHeaderView: UIView {
    
    private let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        return iv
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    private let productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.numberOfLines = 0
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    init(viewModel: DisplayProductViewModel) {
        super.init(frame: .zero)
        addSubviews()
        addConstraints()
        backgroundColor = .white
        productNameLabel.text = viewModel.productName
        productDescriptionLabel.text = viewModel.productDescription
        productPriceLabel.text = viewModel.productPrice
        viewModel.getProductImage(complete: {
            [weak self] imageData in
            DispatchQueue.main.async {
                if let imageData = imageData {
                    self?.productImageView.image = UIImage(data: imageData)
                } else {
                    self?.productImageView.image = nil
                }
            }
        })
    }
    
    private func addSubviews() {
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(productDescriptionLabel)
        addSubview(productPriceLabel)
    }
    
    private func addConstraints() {
        
//        heightAnchor.constraint(equalToConstant: 370).isActive = true
        
        productImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        productImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        productImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        productImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8).isActive = true
        productNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true

        productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 4).isActive = true
        productPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        productPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true

        productDescriptionLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 4).isActive = true
        productDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        productDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        productDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
