//
//  AssemblyRegister.swift
//  MarvelHeroes
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Swinject
import Common
import Core
import UI

final public class AssemblyRegister {
    // MARK: - Properties
    private var mainContainer = Container()
    private var assembler: Assembler?

    public init() {
        AppContainer.shared.container = mainContainer
        self.assembler = Assembler(container: mainContainer)
    }
}

// MARK: - Public methods
public extension AssemblyRegister {
    func registerAssemblies() {
//        assembler?.apply(assembly: AppAssembly())
//        assembler?.apply(assemblies: CoreAssemblyCollector.getBaseAssemblies())
//        assembler?.apply(assemblies: UIAssemblyCollector.getBaseAssemblies())
        assembler?.apply(assemblies: CoreAssemblyCollector.getAssemblies())
        assembler?.apply(assemblies: UIAssemblyCollector.getAssemblies())
    }
}
