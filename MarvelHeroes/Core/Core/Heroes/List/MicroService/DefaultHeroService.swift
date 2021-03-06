//
//  DefaultHeroService.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import RxSwift

final class DefaultHeroService {
    // MARK: - Properties
    private let apiClient: ApiClientServiceInterface

    // MARK: - Init
    init(apiClient: ApiClientServiceInterface) {
        self.apiClient = apiClient
    }
}

// MARK: - HeroServiceInterface
extension DefaultHeroService: HeroServiceInterface {
    func getHeroes(searchText: String?) -> Single<Heroes.Hero.GetHeroesList.Response> {
        let request = Heroes.Hero.GetHeroesList.Request(searchText: searchText)

        return apiClient.make(request)
    }
}

