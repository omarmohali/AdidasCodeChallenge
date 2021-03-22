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
    
    private let ratingValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12.0)
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
        contentView.addSubview(ratingValueLabel)
        contentView.addSubview(reviewTextLabel)
    }
    
    private func addConstraints() {
        ratingValueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        ratingValueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        ratingValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        reviewTextLabel.topAnchor.constraint(equalTo: ratingValueLabel.bottomAnchor, constant: 4).isActive = true
        reviewTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        reviewTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        reviewTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
    }
    
    private func bindData(viewModel: ReviewCellViewModel) {
        ratingValueLabel.text = viewModel.ratingValue
        reviewTextLabel.text = viewModel.reviewText
    }
}


