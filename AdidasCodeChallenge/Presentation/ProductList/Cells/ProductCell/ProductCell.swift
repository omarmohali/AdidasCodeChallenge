//
//  ProductCell.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 20/03/2021.
//

import UIKit

class ProductCell: UITableViewCell {
    
    var viewModel: DisplayProductViewModel? {
        didSet {
            if let viewModel = viewModel {
                bindData(viewModel: viewModel)
            }
        }
    }
    
    private let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.numberOfLines = 3
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
        backgroundColor = .white
        selectionStyle = .none
    }
    
    private func addSubviews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productDescriptionLabel)
        contentView.addSubview(productPriceLabel)
    }
    
    private func addConstraints() {
        
        productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        
        productNameLabel.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 8).isActive = true
        productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8).isActive = true
        productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16).isActive = true

        productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 4).isActive = true
        productDescriptionLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8).isActive = true
        productDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        productDescriptionLabel.bottomAnchor.constraint(equalTo: productPriceLabel.topAnchor, constant: 4).isActive = true

        productPriceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8).isActive = true
        productPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16).isActive = true
        productPriceLabel.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: -8).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindData(viewModel: DisplayProductViewModel) {
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
}
