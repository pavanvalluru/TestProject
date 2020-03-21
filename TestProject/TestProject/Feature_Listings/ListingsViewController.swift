//
//  ListingsViewController.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class ListingsViewController: UITableViewController {
    let viewModel: ListingsViewModel

    private var loadingIndicator: UIActivityIndicatorView!

    init(viewModel: ListingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"

        setupTableView()
        setupLoadingIndicator()
        setupRefreshControl()
        setupNavBarButtons()
        setupViewModelBindings()

        viewModel.startFetchingListings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    // MARK: GUI setup methods

    private func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.separatorColor = UIColor.clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.allowsSelection = false
        tableView.accessibilityIdentifier = "listingsTable"
        tableView.scrollsToTop = true
    }

    private func setupLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.color = GlobalConstants.appThemeColor
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(loadingIndicator)
        loadingIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor, constant: 0).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: 0).isActive = true
        tableView.bringSubviewToFront(loadingIndicator)
    }

    private func setupNavBarButtons() {
        // TODO filter options
        //let button = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(filterTapped))
        //self.navigationItem.rightBarButtonItem = button

        let deleteButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(deleteTapped))
        self.navigationItem.leftBarButtonItem = deleteButton
    }

    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Ihre Anfrage wird bearbeitet…")
        refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }

    private func setupViewModelBindings() {
        viewModel.onFetchStart = {
            DispatchQueue.main.async {
                self.tableView.resetBackgroundView()
                if !(self.refreshControl?.isRefreshing ?? true) {
                    self.loadingIndicator.startAnimating()
                }
            }
        }
        viewModel.onFetchComplete = {
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
        viewModel.onFetchFailed = { error in
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                self.refreshControl?.endRefreshing()
                let alertView = UIAlertController(title: "Error", message: error ?? "", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alertView, animated: true)
            }
        }
    }

    // MARK: User action handlers

    @objc func filterTapped() {
        // TODO
    }

    @objc func handleRefreshControl() {
        viewModel.startFetchingListings()
    }

    @objc func deleteTapped() {
        viewModel.clearListings()
        tableView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension ListingsViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.getTotalNumberOfItemsToShow()
        if count == 0 {
            tableView.setMessageOnBackgroundView("Ist es eine Geisterstadt ?\nBitte \"Pull-to-Refresh\"")
        } else {
            tableView.resetBackgroundView()
        }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListingsViewCell.self)) ??
            ListingsViewCell(style: .default, reuseIdentifier: String(describing: ListingsViewCell.self))
        if let listing = viewModel.getListing(for: indexPath.row) {
            (cell as? ListingsViewCell)?.updateAppearanceFor(listing, animated: true)
        }

        return cell
    }
}

extension ListingsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        Log.info("prefetch called: \(indexPaths.count)")
    }

    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        Log.info("cancel prefetching \(indexPaths.count)")
    }
}
