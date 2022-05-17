//
//  TableViewComponent.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common
import RxCocoa
import RxDataSources
import RxSwift

final class TableViewComponent<Cell: UITableViewCell & UIDataBinder>: BaseTableViewComponent, UITableViewDelegate {

    // MARK: - Private properties
    private var cellEventsPublishSubject: PublishSubject<(Cell, Int)>?
    private let bag = DisposeBag()

    override func setupTableView() {
        super.setupTableView()

        tableView.register(Cell.self)
    }
}

// MARK: - Data binding
extension TableViewComponent: UIDataBinder {
    struct Data {
        let items: Driver<[Cell.Data]>
        let loading: Driver<Bool>
        let contentInset: Driver<UIEdgeInsets>
        let errorOccurred: Driver<Bool>
        let isHidden: Driver<Bool>

        init(items: Driver<[Cell.Data]>,
             loading: Driver<Bool> = .just(false),
             contentInset: Driver<UIEdgeInsets> = .just(Constants.contentInset),
             errorOccurred: Driver<Bool> = .just(false),
             isHidden: Driver<Bool> = .just(false)) {
            self.items = items
            self.errorOccurred = errorOccurred
            self.loading = loading
            self.contentInset = contentInset
            self.isHidden = isHidden
        }
    }

    func bind(data: Data) {
        self.bind(loading: data.loading)

        let dataSource = Driver.combineLatest(data.errorOccurred, data.items)
            .debug("")
            .do( onNext: { [weak self] errorOccurred, items in
                self?.tableView.allowsSelection = !errorOccurred
            })
            .map { errorOccurred, items -> [CellType] in
                return items.map { CellType.contentItem(data: $0) }
            }
        self.bind(items: dataSource)
        self.bind(contentInset: data.contentInset)

        data.isHidden
            .drive(rx.isHidden)
            .disposed(by: bag)
    }
}

// MARK: - Event providing
extension TableViewComponent: EventProvider {
    struct Events {
        let listRefresh: ControlEvent<Void>
        let selectedItem: ControlEvent<IndexPath>
    }

    var events: Events {
        return Events(
            listRefresh: listRefresh,
            selectedItem: tableView.rx.itemSelected
        )
    }
}

// MARK: - Cell event providing
extension TableViewComponent where Cell: CellEventProvider {
    struct CellEvents {
        let events: Cell.Events
        let indexPath: IndexPath
        let bag: DisposeBag
    }

    var cellEvents: Observable<CellEvents> {
        let publishSubject = PublishSubject<(Cell, Int)>()
        self.cellEventsPublishSubject = publishSubject

        return publishSubject.asObserver()
            .map { (cell, row) in
                return CellEvents(
                    events: cell.events,
                    indexPath: IndexPath(row: row, section: 0),
                    bag: cell.bag
                )
            }
    }
}

// MARK: - Private
private extension TableViewComponent {
    enum CellType {
        case contentItem(data: Cell.Data)
    }

    // MARK: Binding
    func bind(items: Driver<[CellType]>) {
        items.asObservable()
            .debug("items")
            .bind(to: tableView.rx.items) { [weak self] _, row, element -> UITableViewCell in
                guard let self = self else { return UITableViewCell() }

                let indexPath = IndexPath(row: row, section: 0)
                switch element {
                case let .contentItem(data):
                    return self.contentCell(for: indexPath, data: data)
                }
            }
            .disposed(by: bag)

        self.tableView.rx.setDelegate(self).disposed(by: bag)
    }

    func contentCell(for indexPath: IndexPath, data: Cell.Data) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.bind(data: data)
        cell.accessibilityIdentifier = "item_\(indexPath.row)"
        self.cellEventsPublishSubject?.onNext((cell, indexPath.row))
        return cell
    }
}

// MARK: - Constants
private enum Constants {
    static let contentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
}

