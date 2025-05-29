//
//  Factory.swift
//  iosApp
//
//  Created by Monokouma on 22/05/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import Swinject

struct ViewModelFactory {
    static func makeMainViewModel() -> MainViewModel {
        DependencyContainer.shared.resolve(MainViewModel.self)
    }
}
