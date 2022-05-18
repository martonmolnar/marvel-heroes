//
//  UIView+Layout.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit

extension UIView {
    func anchorToSuperview(top: Bool = true, bottom: Bool = true, leading: Bool = true, trailing: Bool = true) {
        guard let superview = self.superview else { return }

        topAnchor.constraint(equalTo: superview.topAnchor).isActive = top
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = bottom
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = leading
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = trailing
    }
}
