//
//  UIView+Load.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit

extension UIView {
    class func instance(backgroundColor: UIColor = .clear) -> Self {
        let view = Self()
        view.backgroundColor = backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
