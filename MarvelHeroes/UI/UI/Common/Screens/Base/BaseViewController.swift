//
//  BaseViewController.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit

open class StaticViewController: UIViewController {
    // MARK: - Properties
    public private(set) lazy var topStackView = setupTopStackView()
    public private(set) lazy var topFloatingStackView = setupTopFloatingStackView()
    public private(set) lazy var contentStackView = setupContentStackView()
    public private(set) lazy var bottomStackView = setupBottomStackView()
    public private(set) lazy var bottomFloatingStackView = setupBottomFloatingStackView()

    private let topContainerView = UIView.instance()
    private var topFloatingContainerView: UIView!
    private let containerView = UIView.instance()
    private let bottomContainerView = UIView.instance()
    private var bottomFloatingContainerView: UIView!
    private var topContainerViewHeight: NSLayoutConstraint!
    private var bottomContainerViewHeight: NSLayoutConstraint!

    open var contentContainerView: UIView {
        containerView
    }
    open var contentDistribution: UIStackView.Distribution {
        .fillEqually
    }

    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupTopContainer()
        setupBottomContainer()
        setupContentContainer()
    }
}

// MARK: - Public
public extension StaticViewController {
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

    // MARK: Top floating
    func add(topFloatingComponent: Component, with spacing: CGFloat = 0) {
        topFloatingStackView.addArrangedSubview(topFloatingComponent)
        if spacing != 0 {
            topFloatingStackView.setCustomSpacing(spacing, after: topFloatingComponent)
        }
    }

    // MARK: Bottom
    func add(bottomComponent: Component, with spacing: CGFloat = 0) {
        bottomStackView.addArrangedSubview(bottomComponent)
        if spacing != 0 {
            bottomStackView.setCustomSpacing(spacing, after: bottomComponent)
        }
    }

    // MARK: Bottom floating
    func add(bottomFloatingComponent: Component, with spacing: CGFloat = 0) {
        bottomFloatingStackView.addArrangedSubview(bottomFloatingComponent)
        if spacing != 0 {
            bottomFloatingStackView.setCustomSpacing(spacing, after: bottomFloatingComponent)
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
private extension StaticViewController {
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

    func setupBottomContainer() {
        view.addSubview(bottomContainerView)

        bottomContainerViewHeight = bottomContainerView.heightAnchor.constraint(equalToConstant: 0)
        bottomContainerViewHeight.priority = .required

        bottomContainerView.anchorToSuperview(top: false, bottom: false)
        NSLayoutConstraint.activate([
            bottomContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomContainerViewHeight
        ])
    }

    func setupContentContainer() {
        view.addSubview(contentContainerView)

        contentContainerView.anchorToSuperview(top: false, bottom: false)
        NSLayoutConstraint.activate([
            contentContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: Constants.stackviewSpacing),
            contentContainerView.bottomAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: Constants.stackviewSpacing)
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

    func setupTopFloatingStackView() -> UIStackView {
        topFloatingContainerView = UIView.instance()
        view.addSubview(topFloatingContainerView)
        topFloatingContainerView.anchorToSuperview(top: false, bottom: false)
        topFloatingContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true

        let stackView = UIStackView.instance()
        stackView.axis = .vertical
        topFloatingContainerView.addSubview(stackView)
        stackView.anchorToSuperview()
        stackView.widthAnchor.constraint(equalTo: topFloatingContainerView.widthAnchor).isActive = true
        return stackView
    }

    func setupBottomStackView() -> UIStackView {
        let stackView = UIStackView.instance()
        stackView.axis = .vertical
        bottomContainerView.addSubview(stackView)
        stackView.anchorToSuperview()
        stackView.widthAnchor.constraint(equalTo: bottomContainerView.widthAnchor).isActive = true

        bottomContainerViewHeight.priority = .fittingSizeLevel

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

    func setupBottomFloatingStackView() -> UIStackView {
        bottomFloatingContainerView = UIView.instance()
        view.addSubview(bottomFloatingContainerView)
        bottomFloatingContainerView.anchorToSuperview(top: false, bottom: false)
        bottomFloatingContainerView.bottomAnchor.constraint(equalTo: bottomContainerView.topAnchor).isActive = true

        let stackView = UIStackView.instance()
        stackView.axis = .vertical
        bottomFloatingContainerView.addSubview(stackView)
        stackView.anchorToSuperview()
        stackView.widthAnchor.constraint(equalTo: bottomFloatingContainerView.widthAnchor).isActive = true
        return stackView
    }
}

// MARK: - Constants
private extension StaticViewController {
    enum Constants {
        static let stackviewSpacing: CGFloat = 0
    }
}
