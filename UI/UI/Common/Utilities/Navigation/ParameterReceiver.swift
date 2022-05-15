//
//  ParameterReceiver.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

public protocol ParameterReceiver {
    func setParameter(param: NavigationParameter)
}

public extension ParameterReceiver {
    func setParameter(param: NavigationParameter) {
        fatalError("ParameterReceiver NOT IMPLEMENTED for: \(self)")
    }
}
