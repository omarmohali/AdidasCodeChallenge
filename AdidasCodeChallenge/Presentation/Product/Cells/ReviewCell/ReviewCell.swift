//
//  ReviewCell.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 21/03/2021.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    var viewModel: ReviewCellViewModel? {
        didSet {
            if let viewModel = viewModel {
                bindData(viewModel: viewModel)
            }
        }
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private let ratingValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private let reviewTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(ratingValueLabel)
        containerView.addSubview(reviewTextLabel)
    }
    
    private func addConstraints() {
        
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        ratingValueLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4).isActive = true
        ratingValueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        ratingValueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        
        reviewTextLabel.topAnchor.constraint(equalTo: ratingValueLabel.bottomAnchor, constant: 4).isActive = true
        reviewTextLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        reviewTextLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        reviewTextLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4).isActive = true
    }
    
    private func bindData(viewModel: ReviewCellViewModel) {
        ratingValueLabel.text = viewModel.ratingValue
        reviewTextLabel.text = viewModel.reviewText
    }
}


