//
//  HeroDetailsScreen.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 18..
//

import Foundation

final class HeroDetailsScreen: StaticViewController, ParameterizableController {
    // MARK: - Components
    private let heroDetailsComponent = HeroDetailsComponent.instantiateFromNib(id: AccessibilityId.heroDetails)


    // MARK: - Properties
    var dataBinder: HeroDetailsDataBinder?
    var eventListener: HeroDetailsEventListener?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupComponents()
        setupBindings()
    }
}

// MARK: - Private
private extension HeroDetailsScreen {
    func setupComponents() {
        add(component: heroDetailsComponent)
    }

    func setupBindings() {
        let events = HeroDetailsEventListener.Events(
            viewWillAppear: rx.viewWillAppear
        )

        eventListener?.listen(events: events)

        guard let data = dataBinder?.bind() else { return }


        heroDetailsComponent.bind(data: data.heroDetailsComponentData)
    }
}

// MARK: - Accessibility
private extension HeroDetailsScreen {
    enum AccessibilityId {
        static let heroDetails = "hero_details"
    }
}

