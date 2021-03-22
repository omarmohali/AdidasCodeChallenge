//
//  ViewController.swift
//  AdidasCodeChallenge
//
//  Created by Omar Ali on 20/03/2021.
//

import UIKit

class ProductsViewController: ViewController<ProductsViewModel> {

    private let productCellId = "ProductCell"
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ProductCell.self, forCellReuseIdentifier: productCellId)
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        return tv
    }()
    
    override init(viewModel: ProductsViewModel) {
        super.init(viewModel: viewModel)
        addSubviews()
        addConstraints()
        viewModel.filteredDidChange = {
            [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
    }

    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 16, y: view.frame.width - 16, width: view.frame.width - 32, height: 20))
        searchBar.delegate = self
        return searchBar
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        viewModel.viewDidAppear()
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getFilteredProductsViewModels()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: productCellId) as! ProductCell
        cell.viewModel = viewModel.getFilteredProductsViewModels()?[indexPath.row]
        return cell
    }
}


extension ProductsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let product = viewModel.getFilteredProducts()?[indexPath.row] else {
            return
        }
        
        let productViewModel = ProductViewModel(product: product)
        let productViewController = ProductViewController(viewModel: productViewModel)
        DispatchQueue.main.async {
            [weak self] in
            self?.navigationController?.pushViewController(productViewController, animated: true)
        }
    }
}

extension ProductsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
}


