//
//  UIStackView+Layout.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit

extension UIStackView {
    func remove(view: UIView) {
        guard view.superview != nil else { return }

        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeAllSubview() {
        for subview in self.arrangedSubviews {
            removeArrangedSubview(subview)
            NSLayoutConstraint.deactivate(subview.constraints)
            subview.removeFromSuperview()
        }
    }
}
