//
//  RefreshableWrapper.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common
import UIKit

public class RefreshableWrapper {
    private var refreshCallback: () -> Void

    public init(scrollview: UIScrollView, refresh: @escaping () -> Void) {
        self.refreshCallback = refresh
        addRefreshable(to: scrollview)
    }
}

// MARK: - Refreshable
extension RefreshableWrapper: Refreshable {
    public func refresh(_ refreshControl: UIRefreshControl) {
        refreshCallback()
    }
}
