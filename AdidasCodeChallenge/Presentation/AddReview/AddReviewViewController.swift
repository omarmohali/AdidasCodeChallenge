//
//  AddReviewViewController.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 22/03/2021.
//

import UIKit

class AddReviewViewController: UIViewController {
    
    private lazy var starsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            getStarImageView(tag: 1),
            getStarImageView(tag: 2),
            getStarImageView(tag: 3),
            getStarImageView(tag: 4),
            getStarImageView(tag: 5)
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.layer.cornerRadius = 5
        tv.layer.borderWidth  = 1
        tv.layer.borderColor = UIColor.black.cgColor
        tv.text = ""
        tv.backgroundColor = .white
        tv.textColor = .black
        return tv
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Submit", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(actionOfSubmitButton), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private var rating = 0
    private let complete:  (_ rating: Int, _ text: String) -> Void
    init(complete: @escaping (_ rating: Int, _ text: String) -> Void) {
        self.complete = complete
        super.init(nibName: nil, bundle: nil)
        addSubviews()
        addConstraints()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(actionOfCancelButton))
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    private func addSubviews() {
        view.addSubview(starsStackView)
        view.addSubview(textView)
        view.addSubview(submitButton)
    }
    
    private func addConstraints() {
        
        starsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        starsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        starsStackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        starsStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        textView.topAnchor.constraint(equalTo: starsStackView.bottomAnchor, constant: 16).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        submitButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc private func actionOfCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getStarImageView(tag: Int) -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: "star"))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.tag = tag
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnStar(sender:))))
        return imageView
    }
    
    @objc private func didTapOnStar(sender: UITapGestureRecognizer) {
        guard let rating  = sender.view?.tag else { return }
        self.rating = rating
        for view in starsStackView.arrangedSubviews {
            if view.tag <= rating {
                (view as? UIImageView)?.image = UIImage(systemName: "star.fill")
            } else {
                (view as? UIImageView)?.image = UIImage(systemName: "star")
            }
        }
        enableSubmitButton()
    }
    
    private func enableSubmitButton() {
        submitButton.backgroundColor = .black
        submitButton.isEnabled = true
    }
    
    @objc private func actionOfSubmitButton() {
        
        dismiss(animated: true, completion: {
            [weak self] in
            guard let self = self else { return }
            self.complete(self.rating, self.textView.text)
        })
    }
    
}
