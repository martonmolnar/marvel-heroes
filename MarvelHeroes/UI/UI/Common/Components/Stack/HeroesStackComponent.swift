//
//  HeroesStackComponent.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit

final class HeroesStackComponent: Component {
    private(set) var stackView: HeroesStackView

    convenience init(stackView: HeroesStackView) {
        self.init(frame: .zero)
        self.stackView = stackView
        setupStackView()
    }

    override init(frame: CGRect) {
        stackView = HeroesStackView(frame: .zero)
        super.init(frame: frame)
        setupStackView()
    }

    required init?(coder aDecoder: NSCoder) {
        stackView = HeroesStackView(frame: .zero)
        super.init(coder: aDecoder)
        setupStackView()
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
}

extension HeroesStackComponent {
    func setHeight(_ height: CGFloat) {
        stackView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func setStackViewSpacing(with spacing: CGFloat) {
        stackView.setStackViewSpacing(with: spacing)
    }

    func addComponent(_ component: Component) {
        stackView.addComponent(component)
    }

    func addComponents(_ components: [Component]) {
        components.forEach { [unowned self] component in
            self.addComponent(component)
        }
    }

    func removeAllComponents() {
        stackView.removeAllComponents()
    }
}

