//
//  HeroesListScreen.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit

final class HeroesListScreen: BaseViewController {
    // MARK: - Components
    private let stackComponent = HeroesStackComponent()
    
    // MARK: - Properties
//    var dataBinder: HeroesListDataBinder?
//    var eventListener: HeroesListEventListener?

//    override var stackViewTopPadding: CGFloat { Constants.stackViewTopPadding }
//    private let bag = DisposeBag()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupComponents()
        setupBindings()
    }
}

// MARK: - Private
private extension HeroesListScreen {
    func setupComponents() {
    }

    func setupStackComponent() {
        stackComponent.stackView.axis = .horizontal
        stackComponent.stackView.alignment = .fill
        stackComponent.stackView.distribution = .equalSpacing
        stackComponent.stackView.layoutMargins = Constants.stackViewLayoutMargins
        stackComponent.stackView.isLayoutMarginsRelativeArrangement = true
    }

    func setupBindings() {
        setupStackComponent()
        add(component: stackComponent)
    }
}

// MARK: - Constants
private extension HeroesListScreen {
    enum Constants {
        static let stackViewTopPadding: CGFloat = 20
        static let stackViewLayoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        static let componentSpacing: CGFloat = 10
    }
}

// MARK: - Accessibility
private extension HeroesListScreen {
    enum AccessibilityId {
        static let selectedFilters = "selected_filters"
        static let activateAll = "activate_all"
        static let infoLabel = "info_label"
        static let list = "list"
    }
}
