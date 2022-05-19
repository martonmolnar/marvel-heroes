//
//  AssertionWrapper.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import Foundation

/// Overrides `Swift.fatalError(...)`
public func fatalError(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Never {
    AssertionWrapper.fatalError(message(), file, line)
}

public enum AssertionWrapper {
    public static var fatalError: (String, StaticString, UInt) -> Never = realFatalError

    private static let realFatalError = { Swift.fatalError($0, file: $1, line: $2) }

    public static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalError = closure
    }

    public static func restoreFatalError() {
        fatalError = realFatalError
    }
}

