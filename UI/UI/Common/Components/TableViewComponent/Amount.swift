//
//  Amount.swift
//  OTPUI
//
//  Created by Gergo Nemeth on 2018. 03. 02..
//  Copyright © 2018. Supercharge Ltd. All rights reserved.
//

public enum Alignment {
    case left
    case center
    case right
}

public struct Amount: Equatable {
    public var formattedBalance: String?
    public var currency: String?
    public var isLoading: Bool
    public var alignment: Alignment
    public var value: Decimal

    public init(formattedBalance: String? = nil,
                currency: String? = nil,
                isLoading: Bool = true,
                alignment: Alignment = .right,
                value: Decimal = 0) {
        self.formattedBalance = formattedBalance
        self.currency = currency
        self.isLoading = isLoading
        self.alignment = alignment
        self.value = value
    }
}
