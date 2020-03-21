//
//  FavoritesViewController.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 21.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController {

    let viewModel: FavoritesViewModel

    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.title = "Favorites"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"

        setupTableViewProperties()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tableView.reloadData()
    }

    private func setupTableViewProperties() {
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.accessibilityIdentifier = "favoritesTable"
        tableView.scrollsToTop = true
    }
}

// MARK: - UICollectionViewDataSource
extension FavoritesViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.bookmarks.count
        if count == 0 {
            tableView.setMessageOnBackgroundView("Keine Favorites verfügbar!")
        } else {
            tableView.resetBackgroundView()
        }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListingsViewCell.self)) ??
            ListingsViewCell(style: .default, reuseIdentifier: String(describing: ListingsViewCell.self))
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UICollectionViewDelegate
extension FavoritesViewController {

    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        (cell as? ListingsViewCell)?.updateAppearanceFor(viewModel.bookmarks[indexPath.row], animated: true)
    }

}
