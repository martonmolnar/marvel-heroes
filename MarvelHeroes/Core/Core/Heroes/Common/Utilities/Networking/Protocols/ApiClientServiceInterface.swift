//
//  ApiClientServiceInterface.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import RxSwift

protocol ApiClientServiceInterface {
    func makeRequest<T>(_ request: APIRequest<T>, behaviours: [RequestBehaviour]) -> Single<T>
}

// MARK: Default function parameter values
extension ApiClientServiceInterface {
    func make<T>(_ request: APIRequest<T>, behaviours: [RequestBehaviour] = []) -> Single<T> {
        return makeRequest(request, behaviours: behaviours)
    }
}
