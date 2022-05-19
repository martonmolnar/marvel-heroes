//
//  HeroesListScreen.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit
import RxSwift
import RxCocoa

final class HeroesListScreen: StaticViewController {
    // MARK: - Components
    private var searchFieldComponent: SearchFieldComponent!
    private let tableViewComponent = TableViewComponent<HeroesCell>(id: AccessibilityId.list)
    
    // MARK: - Properties
    var dataBinder: HeroesListDataBinder?
    var eventListener: HeroesListEventListener?

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
        
        setupSearchFieldComponent()
        tableViewComponent.config = TableViewComponentConfig(pullToRefreshEnabled: false)
        add(topComponent: searchFieldComponent)
        add(component: tableViewComponent)
    }

    func setupSearchFieldComponent() {
        searchFieldComponent = SearchFieldComponent.instantiateFromNib()
        searchFieldComponent.anchorToSuperview()
    }

    func setupBindings() {
        let events = HeroesListEventListener.Events(
            textSearchEvents: searchFieldComponent.events,
            viewWillAppear: rx.viewWillAppear,
            listEvents: tableViewComponent.events,
            cellEvents: ControlEvent(events: tableViewComponent.cellEvents)
        )
        eventListener?.listen(events: events)

        guard let data = dataBinder?.bind() else { return }

        self.title = data.title
        tableViewComponent.bind(data: data.listData)
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
        static let list = "list"
    }
}
