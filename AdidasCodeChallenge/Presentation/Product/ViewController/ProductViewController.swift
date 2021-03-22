//
//  ProductViewController.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 21/03/2021.
//

import UIKit

class ProductViewController: ViewController<ProductViewModel> {
    
    private let reviewCellId = "Cell"
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ReviewCell.self, forCellReuseIdentifier: reviewCellId)
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        return tv
    }()
    
    override init(viewModel: ProductViewModel) {
        super.init(viewModel: viewModel)
        addSubviews()
        addConstraints()
        
        viewModel.productDidChange = {
            [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.estimatedSectionHeaderHeight = 300
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let addReviewButton = UIBarButtonItem(title: "Add Review", style: .plain, target: self, action: #selector(actionOfAddReviewButton))
        navigationItem.rightBarButtonItem = addReviewButton
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func addConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc private func actionOfAddReviewButton() {
        let addReviewViewController = AddReviewViewController(complete: {
            [weak self] rating, text in
            self?.viewModel.didPostReview(rating: rating, reviewText: text)
        })
        
        let addReviewNavigationController = UINavigationController(rootViewController: addReviewViewController)
        
        present(addReviewNavigationController, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProduct().reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reviewCellId) as! ReviewCell
        cell.viewModel = ReviewCellViewModel(review: viewModel.getProduct().reviews[indexPath.row])
        return cell
    }

}


extension ProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dispayProductViewModel = DisplayProductViewModel(product: viewModel.getProduct())
        let productHeaderView = ProductHeaderView(viewModel: dispayProductViewModel)
        return productHeaderView
    }
}
