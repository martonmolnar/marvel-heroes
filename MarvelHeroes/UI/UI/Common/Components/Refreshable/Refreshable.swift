//
//  Refreshable.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit

@objc public protocol Refreshable: class {
    func refresh(_ refreshControl: UIRefreshControl)
}

extension Refreshable {
    func addRefreshable(to scrollView: UIScrollView) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        refreshControl.accessibilityIdentifier = "refresh_control"
        scrollView.refreshControl = refreshControl
        scrollView.sendSubviewToBack(refreshControl)
    }

    func removeRefreshable(from scrollView: UIScrollView) {
        scrollView.refreshControl = nil
    }

    func refresh(_ refreshControl: UIRefreshControl) {
        preconditionFailure("This method must be overridden")
    }

    func beginRefresh(_ scrollView: UIScrollView) {
        guard let refreshControl = scrollView.refreshControl else { return }
        scrollView.contentOffset = CGPoint(x: 0.0, y: -refreshControl.frame.size.height)
        scrollView.refreshControl?.beginRefreshing()
    }

    func endRefresh(_ scrollView: UIScrollView, shouldPreserveState: Bool = false) {
        if !shouldPreserveState {
            scrollView.contentOffset = .zero
        }
        scrollView.refreshControl?.endRefreshing()
    }
}

