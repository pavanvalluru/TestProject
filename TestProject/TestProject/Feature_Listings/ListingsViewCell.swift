//
//  ListingsViewCell.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class ListingsViewCell: UITableViewCell {
    var titleLabel: UILabel!
    var addressLabel: UILabel!
    var priceLabel: UILabel!
    var bookmarkButton: UIButton!
    var imageToShow: URLCachableImageView!
    var loadingIndicator: UIActivityIndicatorView!
    var container: UIView!

    var cellViewModel: ListingsViewCellViewModel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: GUI setup methods

    private func addViews() {
        self.contentView.backgroundColor = UIColor.white

        setupContainerView().setupAddressLabel().setupTitleLabel().setupImageView()
            .setupPriceLabel().setupBookmarkButton().setupLoadingIndicator()
    }

    @discardableResult
    private func setupContainerView() -> ListingsViewCell {
        container = UIView()
        container.clipsToBounds = true
        container.layer.borderWidth = 0.5
        container.layer.borderColor = UIColor.gray.cgColor
        container.layer.cornerRadius = 10

        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            container.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            container.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
        return self
    }

    @discardableResult
    private func setupAddressLabel() -> ListingsViewCell {
        addressLabel = UILabel()
        addressLabel.text = "Address"
        addressLabel.textColor = UIColor.gray
        addressLabel.font = .systemFont(ofSize: 14)
        container.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 8),
            addressLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -8),
            addressLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8)
            ])
        return self
    }

    @discardableResult
    private func setupTitleLabel() -> ListingsViewCell {
        titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        container.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: addressLabel.topAnchor, constant: -8)
            ])
        return self
    }

    @discardableResult
    private func setupImageView() -> ListingsViewCell {
        imageToShow = URLCachableImageView()
        container.addSubview(imageToShow)
        imageToShow.translatesAutoresizingMaskIntoConstraints = false
        let imageHeightConstraint = imageToShow.heightAnchor.constraint(equalToConstant: 250)
        imageHeightConstraint.priority = UILayoutPriority(rawValue: 999)
        NSLayoutConstraint.activate([
            imageToShow.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8),
            imageToShow.leftAnchor.constraint(equalTo: container.leftAnchor),
            imageToShow.topAnchor.constraint(equalTo: container.topAnchor, constant: -16),
            imageToShow.rightAnchor.constraint(equalTo: container.rightAnchor),
            imageHeightConstraint
            ])
        return self
    }

    @discardableResult
    private func setupPriceLabel() -> ListingsViewCell {
        priceLabel = UILabel()
        priceLabel.backgroundColor = GlobalConstants.appThemeColor
        priceLabel.textColor = GlobalConstants.appTintColor
        priceLabel.layer.cornerRadius = 10.0
        priceLabel.clipsToBounds = true
        priceLabel.layer.borderWidth = 1.0
        priceLabel.layer.borderColor = UIColor.white.cgColor
        priceLabel.font = .systemFont(ofSize: 20)
        container.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.rightAnchor.constraint(equalTo: imageToShow.rightAnchor, constant: -16),
            priceLabel.bottomAnchor.constraint(equalTo: imageToShow.bottomAnchor, constant: -16),
            priceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: imageToShow.leadingAnchor, constant: 16)
            ])
        return self
    }

    @discardableResult
    private func setupBookmarkButton() -> ListingsViewCell {
        bookmarkButton = UIButton()
        bookmarkButton.addTarget(self, action: #selector(onBookmarkTapped), for: .touchUpInside)
        bookmarkButton.contentMode = .scaleAspectFit
        bookmarkButton.setImage(UIImage(named: .bookmark_off), for: .normal)
        bookmarkButton.backgroundColor = UIColor.clear
        addSubview(bookmarkButton)
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookmarkButton.rightAnchor.constraint(equalTo: imageToShow.rightAnchor, constant: -16),
            bookmarkButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        return self
    }

    @discardableResult
    private func setupLoadingIndicator() -> ListingsViewCell {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.color = GlobalConstants.appThemeColor
        loadingIndicator.hidesWhenStopped = true
        imageToShow.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: imageToShow.centerXAnchor, constant: 0),
            loadingIndicator.centerYAnchor.constraint(equalTo: imageToShow.centerYAnchor, constant: 0)
            ])
        return self
    }

}

// MARK: Cell customisation methods
extension ListingsViewCell {

    func updateAppearanceFor(_ listing: Listing, animated: Bool = true) {
        self.cellViewModel = ListingsViewCellViewModel(listing: listing)
        DispatchQueue.main.async {
            if animated {
                UIView.animate(withDuration: 0.5) {
                    self.displayListingInfo(listing)
                }
            } else {
                self.displayListingInfo(listing)
            }
        }
    }

    private func setDefaultImageIfNoImageAvailable() {
        DispatchQueue.main.async {
            self.imageToShow.image = UIImage(named: .wohnung)
        }
    }

    private func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
    }

    private func updateBookmarkButtonIcon() {
        if cellViewModel.isBookmarked {
            bookmarkButton.setImage(UIImage(named: .bookmark_on), for: .normal)
        } else {
            bookmarkButton.setImage(UIImage(named: .bookmark_off), for: .normal)
        }
    }

    @objc func onBookmarkTapped() {
        cellViewModel.onBookmarkTapped()
        updateBookmarkButtonIcon()
    }

    private func displayListingInfo(_ listing: Listing) {
        cellViewModel.listingInfo = listing

        titleLabel.text = listing.title
        addressLabel.text = listing.location.address
        priceLabel.text = cellViewModel.listingPriceString
        updateBookmarkButtonIcon()
        startFetchingImage()
    }

    func startFetchingImage() {
        if let imageURL = cellViewModel.listingInfo.images?.first?.url {
            self.loadingIndicator.startAnimating()
            _ = imageToShow.fetchImage(fromURLString: imageURL,
                                       usingClientService: MyClientService(),
                                       usingCache: ImageCache.shared) { [weak self] success in
                    // stop activity indicator if any
                    self?.stopActivityIndicator()
                    if !success {
                        self?.setDefaultImageIfNoImageAvailable()
                    }
            }
        }
    }

    func cancelCurrentFetch() {
        imageToShow.cancelCurrentFetch()
        setDefaultImageIfNoImageAvailable()
    }
}
