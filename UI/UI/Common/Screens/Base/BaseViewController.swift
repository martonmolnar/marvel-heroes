//
//  BaseViewController.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit

public class BaseViewController: UIViewController {
    // MARK: - Properties
    public private(set) lazy var topStackView = setupTopStackView()
    public private(set) lazy var contentStackView = setupContentStackView()

    private let topContainerView = UIView.instance()
    private let scrollView = UIScrollView.instance()
    private var topContainerViewHeight: NSLayoutConstraint!

    open var contentContainerView: UIView {
        scrollView
    }
    open var contentDistribution: UIStackView.Distribution {
        .fillEqually
    }

    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupTopContainer()
        setupContentContainer()
    }
}

// MARK: - Public
public extension BaseViewController {
    // MARK: Content
    func add(component: Component, with spacing: CGFloat = 0) {
        contentStackView.addArrangedSubview(component)
        if spacing != 0 {
            contentStackView.setCustomSpacing(spacing, after: component)
        }
    }

    func add(component: Component, before: Component, with spacing: CGFloat = 0) {
        let index = contentStackView.arrangedSubviews.firstIndex(of: before) ?? 0
        contentStackView.insertArrangedSubview(component, at: index)
        if spacing != 0 {
            contentStackView.setCustomSpacing(spacing, after: component)
        }
    }

    func removeComponent(_ component: Component) {
        contentStackView.remove(view: component)
    }

    func removeAllComponents() {
        contentStackView.removeAllSubview()
    }

    // MARK: Top
    func add(topComponent: Component, with spacing: CGFloat = 0) {
        topStackView.addArrangedSubview(topComponent)
        if spacing != 0 {
            topStackView.setCustomSpacing(spacing, after: topComponent)
        }
    }

    // MARK: - Common
    func addEmptyComponent(to stackView: UIStackView, height: CGFloat = 0) {
        let empty = Component.instance()
        stackView.addArrangedSubview(empty)
        empty.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

// MARK: - Setup
private extension BaseViewController {
    // MARK: Setup
    func setup() {
        view.backgroundColor = .lightGray
    }

    // MARK: Containers
    func setupTopContainer() {
        view.addSubview(topContainerView)

        topContainerViewHeight = topContainerView.heightAnchor.constraint(equalToConstant: 0)
        topContainerViewHeight.priority = .required

        topContainerView.anchorToSuperview(top: false, bottom: false)
        NSLayoutConstraint.activate([
            topContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topContainerViewHeight
        ])
    }

    func setupContentContainer() {
        view.addSubview(contentContainerView)

        contentContainerView.anchorToSuperview(top: false, bottom: false)
        NSLayoutConstraint.activate([
            contentContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: Constants.stackviewSpacing),
//            contentContainerView.bottomAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: Constants.stackviewSpacing)
        ])
    }

    // MARK: StackViews
    func setupTopStackView() -> UIStackView {
        let stackView = UIStackView.instance()
        stackView.axis = .vertical
        topContainerView.addSubview(stackView)
        stackView.anchorToSuperview()
        stackView.widthAnchor.constraint(equalTo: topContainerView.widthAnchor).isActive = true

        topContainerViewHeight.priority = .fittingSizeLevel

        return stackView
    }

    func setupContentStackView() -> UIStackView {
        let stackView = UIStackView.instance()
        stackView.axis = .vertical
        stackView.distribution = contentDistribution
        contentContainerView.addSubview(stackView)
        stackView.anchorToSuperview()
        stackView.widthAnchor.constraint(equalTo: contentContainerView.widthAnchor).isActive = true
        return stackView
    }
}

// MARK: - Constants
private extension BaseViewController {
    enum Constants {
        static let stackviewSpacing: CGFloat = 0
    }
}
