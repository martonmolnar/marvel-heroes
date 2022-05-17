//
//  Resolver+Get.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Swinject

public extension Resolver {
    func get<Service>(name: String? = nil) -> Service {
        guard let service = resolve(Service.self, name: name) else {
            fatalError("Service or NAME is not registered. Service: \(Service.self). Name: \(String(describing: name))")
        }
        return service
    }

    func get<Service>(_ serviceType: Service.Type, name: String? = nil) -> Service {
        guard let service = resolve(serviceType, name: name) else {
            fatalError("Service or NAME is not registered. Service: \(Service.self). Name: \(String(describing: name))")
        }
        return service
    }

    func get<Service, Enum: RawRepresentable>(type: Enum) -> Service where Enum.RawValue == Common.ServiceType {
        guard let service = resolve(Service.self, name: type.rawValue) else {
            fatalError("Service or NAME is not registered. Service: \(Service.self). Name: \(String(describing: type))")
        }
        return service
    }

    func get<Service, Enum: RawRepresentable>(_ serviceType: Service.Type, type: Enum) -> Service where Enum.RawValue == Common.ServiceType {
        guard let service = resolve(serviceType, name: type.rawValue) else {
            fatalError("Service or NAME is not registered. Service: \(Service.self). Name: \(String(describing: type))")
        }
        return service
    }
}
