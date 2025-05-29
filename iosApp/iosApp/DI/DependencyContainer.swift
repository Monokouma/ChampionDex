//
//  DependencyContainer.swift
//  iosApp
//
//  Created by Monokouma on 22/05/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import Swinject
import shared

class DependencyContainer {
    static let shared = DependencyContainer()
    
    private let container = Container()
    
    private init() {
        registerViewModels()
    }
    
    private func registerViewModels() {
      

    }
    
    func resolve<T>(_ type: T.Type) -> T {
        return container.resolve(type)!
    }
}
