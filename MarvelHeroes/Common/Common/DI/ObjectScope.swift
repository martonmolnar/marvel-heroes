//
//  ObjectScope.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 16..
//

import Swinject

// MARK: - ObjectScope extension
public extension ObjectScope {

     static let session = ObjectScope(
        storageFactory: PermanentStorage.init,
        description: "session"
    )
}
