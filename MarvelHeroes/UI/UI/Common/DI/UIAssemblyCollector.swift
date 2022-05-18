//
//  UIAssemblyCollector.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Swinject

public enum UIAssemblyCollector {
    public static func getBaseAssemblies() -> [Assembly] {
        return [
//            UICoreAssembly()
        ]
    }

    public static func getAssemblies() -> [Assembly] {
        return [
            HeroesAssembly()
        ]
    }
}
