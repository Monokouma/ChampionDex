package com.despaircorp.championdex

import org.koin.core.context.startKoin

object KoinInitializer {
    fun initKoin() {
        startKoin {
            modules(sharedModule)
        }
    }
}
