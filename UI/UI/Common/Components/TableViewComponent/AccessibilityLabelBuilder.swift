//
//  AccessibilityLabelBuilder.swift
//  OTPUI
//
//  Created by Molnar Marton on 2022. 01. 28..
//

import Foundation

public enum AccessibilityLabelBuilder {
    public static func label(with parameters: [String?]) -> String {
        let element = parameters.compactMap({ $0 })

        return element.joined(separator: ", ")
    }
}
