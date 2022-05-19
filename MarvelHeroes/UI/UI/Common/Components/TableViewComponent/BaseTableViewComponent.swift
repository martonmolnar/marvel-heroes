//
//  BaseTableViewComponent.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common
import RxCocoa
import RxDataSources
import RxSwift

protocol BaseTableViewComponentInterface {
    func configChanged()
    func setupTableView()
    func setup(with tableView: HeroTableView)
}

public class BaseTableViewComponent: Component, BaseTableViewComponentInterface {
    var refreshableWrapper: RefreshableWrapper?
    var listRefresh: ControlEvent<Void>!

    private let bag = DisposeBag()

    weak var tableView: HeroTableView!

    var config: TableViewComponentConfig = .defaultValue() {
        didSet {
            guard config != oldValue else { return }
            configChanged()
        }
    }

    // MARK: - Initializations
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }

    init(id: String? = nil) {
        super.init(frame: .zero)
        self.accessibilityIdentifier = id
        setupComponents()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
    }

    // MARK: - BaseTableViewComponentInterface methods
    func configChanged() {
        setupPullToRefresh()
    }

    func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = TableConstants.estimatedRowHeight
    }

    func setup(with tableView: HeroTableView) {
        if self.tableView != nil {
            self.tableView?.removeFromSuperview()
            self.tableView = nil
        }

        addComponent(tableView, to: self, topConstraintConstant: 0)
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        self.tableView = tableView
    }
}
// MARK: - Binding helpers
extension BaseTableViewComponent {
    func bind(loading: Driver<Bool>) {
        loading.drive(onNext: { [weak self] loading in
            guard let self = self else { return }
            if loading {
                self.refreshableWrapper?.beginRefresh(self.tableView)
            } else {
                self.refreshableWrapper?.endRefresh(self.tableView, shouldPreserveState: true)
            }
        })
        .disposed(by: bag)
    }

    func bind(contentInset: Driver<UIEdgeInsets>) {
        contentInset.drive(onNext: { [tableView] contentInset in
            tableView?.contentInset = contentInset
        })
        .disposed(by: bag)
    }
}

// MARK: - Setup methods
private extension BaseTableViewComponent {
    func setupComponents() {
        self.backgroundColor = .clear
        setup(with: HeroTableView())
        setupTableView()
        setupPullToRefresh()
    }

    func setupPullToRefresh() {
        let pullToRefreshEvents = PublishSubject<Void>()
        listRefresh = ControlEvent(events: pullToRefreshEvents)

        guard config.pullToRefreshEnabled else {
            refreshableWrapper?.removeRefreshable(from: tableView)
            return
        }
        self.refreshableWrapper = RefreshableWrapper(scrollview: tableView, refresh: {
            pullToRefreshEvents.onNext(())
        })
    }

    func addComponent(_ component: UIView, to superView: UIView, topConstraintConstant: CGFloat = 20) {
        component.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(component)
        NSLayoutConstraint.activate([
            component.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            component.topAnchor.constraint(equalTo: superView.topAnchor, constant: topConstraintConstant),
            component.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            component.bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
}

private extension BaseTableViewComponent {
    enum TableConstants {
        static let estimatedRowHeight: CGFloat = 50
    }
}

