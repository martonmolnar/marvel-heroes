//
//  UITableViewCell+Reuse.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit

// MARK: - ReusableView
public protocol ReusableView: class {
}

public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {
}

// MARK: - NibLoadableView
protocol NibLoadableView: class {
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableViewCell: NibLoadableView {
}
