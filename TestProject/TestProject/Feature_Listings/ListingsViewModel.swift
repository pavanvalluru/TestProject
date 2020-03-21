//
//  ListingsViewModel.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

// equivalent to presenter in clean swift
class ListingsViewModel {

    private var listings: [Listing] = []
    private var imageFetchingTasks: [URLSessionTask] = []
    
    let clientService: ClientServiceProtocol
    private lazy var listingsUseCase = ListingsUseCase(delegate: self, service: clientService)

    init(using service: ClientServiceProtocol = MyClientService()) {
        clientService = service
    }

    // MARK: - bindings
    var onFetchStart: (() -> Void)?
    var onFetchComplete: (() -> Void)?
    var onFetchFailed: ((String?) -> Void)?

    func startFetchingListings() {
        onFetchStart?()
        listingsUseCase.startFetchRequest()
    }

    func getTotalNumberOfItemsToShow() -> Int {
        listings.count
    }

    func getListing(for rowIndex: Int) -> Listing? {
        guard rowIndex < listings.count else {
            return nil
        }
        return listings[rowIndex]
    }

    func clearListings() {
        listings.removeAll()
    }
}

extension ListingsViewModel: ListingsUsecaseProtocol {
    func fetchFinished(with result: [Listing]?) {
        self.listings = result ?? []
        self.onFetchComplete?()
    }

    func fetchError(error: Error) {
        self.onFetchFailed?(error.localizedDescription)
    }
}
