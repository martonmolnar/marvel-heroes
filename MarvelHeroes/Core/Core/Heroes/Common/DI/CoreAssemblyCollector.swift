//
//  CoreAssemblyCollector.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 16..
//

import Swinject

public enum CoreAssemblyCollector {
    public static func getBaseAssemblies() -> [Assembly] {
        return [
//            UICoreAssembly()
        ]
    }

    public static func getAssemblies() -> [Assembly] {
        return [
            CommonAssembly(),
            HeroesAssembly()
        ]
    }
}
