//
//  HeroServiceInterface.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import RxSwift

protocol HeroServiceInterface {
    func getHeroes() -> Single<Heroes.Hero.GetHeroesList.Response>
}
