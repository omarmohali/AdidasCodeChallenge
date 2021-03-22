//
//  ProductViewController.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 21/03/2021.
//

import UIKit

class ProductViewController: UIViewController {
    
    private let reviewCellId = "Cell"
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ReviewCell.self, forCellReuseIdentifier: reviewCellId)
        tv.dataSource = self
        tv.separatorStyle = .none
        return tv
    }()
    
    private let viewModel: ProductViewModel
    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        let dispayProductViewModel = DisplayProductViewModel(product: viewModel.getProduct())
        tableView.tableHeaderView = ProductHeaderView(viewModel: dispayProductViewModel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let addReviewButton = UIBarButtonItem(title: "Add Review", style: .plain, target: self, action: #selector(actionOfAddReviewButton))
        navigationItem.rightBarButtonItem = addReviewButton
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width - 32.0, height: 0)).height
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
