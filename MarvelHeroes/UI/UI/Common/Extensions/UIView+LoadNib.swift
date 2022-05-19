//
//  UIView+LoadNib.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 18..
//

import UIKit

public extension UIView {
    static var nibName: String {
        return String(describing: self)
    }

    class func instantiateFromNib(id: String? = nil, nibName: String? = nil) -> Self {
        return loadFromNib(viewType: self, id: id, nibName: nibName)
    }

    private class func loadFromNib<T: UIView>(viewType: T.Type, id: String? = nil, nibName: String? = nil) -> T {
        let url: NSURL! = NSURL(string: nibName ?? NSStringFromClass(viewType))
        let view = Bundle(for: viewType).loadNibNamed(url.pathExtension!, owner: nil, options: nil)?.first as! T
        view.accessibilityIdentifier = id ?? String(describing: self).lowercased()

        return view
    }
}
