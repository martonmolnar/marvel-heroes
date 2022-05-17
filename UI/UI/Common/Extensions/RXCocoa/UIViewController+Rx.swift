//
//  UIViewController+Rx.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {

    // MARK: - Lifecycle
    var viewWillAppear: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear(_:)))
            .map { _ -> Void in
                // animation input parameter is irrelevant
            }
        return ControlEvent(events: source)
    }

    var viewWillDisappear: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewWillDisappear(_:)))
            .map { _ -> Void in
                // animation input parameter is irrelevant
            }
        return ControlEvent(events: source)
   }

    var viewDidDisappear: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidDisappear(_:)))
            .map { _ -> Void in
                // animation input parameter is irrelevant
            }
        return ControlEvent(events: source)
   }

    var viewDidAppear: ControlEvent<Void> {
      let source = self.methodInvoked(#selector(Base.viewDidAppear(_:)))
        .map { _ -> Void in
            // animation input parameter is irrelevant
        }
      return ControlEvent(events: source)
    }
}

