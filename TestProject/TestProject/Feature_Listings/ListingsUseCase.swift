//
//  ListingsUseCase.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

protocol ListingsUsecaseProtocol: AnyObject {
    func fetchFinished(with result: [Listing]?)
    func fetchError(error: Error)
}

// equivalent to interactor in clean swift
class ListingsUseCase {

    let service: ClientServiceProtocol
    weak var delegate: ListingsUsecaseProtocol?

    init(delegate: ListingsUsecaseProtocol?, service: ClientServiceProtocol) {
        self.delegate = delegate
        self.service = service
    }

    func startFetchRequest() {
        service.getDecodedResponse(from: .fetch, objectType: ImmoList.self) { res in
            switch res {
            case .success(let val):
                self.delegate?.fetchFinished(with: val.listings)
            case .failure(let err):
                self.delegate?.fetchError(error: err)
            }
        }
    }
}
