//
//  ParameterizableController.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 18..
//

import Common

typealias ParameterizableController = Controller & ParameterReceiver

extension Controller where Self: ParameterReceiver {
    func setParameter(param: NavigationParameter) {
        if let parameterReciever = dataBinder as? ParameterReceiver {
            parameterReciever.setParameter(param: param)
        }
        if let parameterReciever = eventListener as? ParameterReceiver {
            parameterReciever.setParameter(param: param)
        }
    }
}

// MARK: - ParameterReceiver
extension EventListener where Self: RxParameterReceiver {
    func setParameter(param: NavigationParameter) {
        guard let parameter: NavigationParameterType = param.getParam() else { return }
        navigationParameter.accept(parameter)
    }
}

extension DataBinder where Self: RxParameterReceiver {
    func setParameter(param: NavigationParameter) {
        guard let parameter: NavigationParameterType = param.getParam() else { return }
        navigationParameter.accept(parameter)
    }
}

