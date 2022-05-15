//
//  HeroesStackView.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit

public class HeroesStackView: UIStackView {
    public func setStackViewSpacing(with spacing: CGFloat) {
        self.spacing = spacing
    }

    public func addComponents(_ components: [Component]) {
        components.forEach { component in
            self.addComponent(component)
        }
    }

    public func addComponent(_ component: Component?, before: Component) {
        guard let component = component, let index = subviews.firstIndex(of: before) else {
            return
        }
        insertArrangedSubview(component, at: index)
    }

    public func addComponent(_ component: Component?) {
        guard let component = component else { return }
        add(component: component)
    }

    public func addComponent(_ component: Component?, before: Component, with spacing: CGFloat) {
        guard let component = component else { return }
        addComponent(component, before: before)
        self.setCustomSpacing(spacing, after: component)
    }

    public func removeComponent(_ component: Component) {
        guard component.superview != nil else { return }

        removeArrangedSubview(component)
        component.removeFromSuperview()
    }

    public func removeAllComponents() {
        for subview in self.arrangedSubviews {
            removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }

    public func arrangedComponentSubviews() -> [UIView] {
        var subviews: [Component] = []
        for case let component as Component in arrangedSubviews {
            subviews.append(component)
        }
        return subviews
    }
}

private extension HeroesStackView {
    func add(component: Component) {
        addArrangedSubview(component)
    }
}
