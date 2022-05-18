//
//  UITableView+CellReuse.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
}

