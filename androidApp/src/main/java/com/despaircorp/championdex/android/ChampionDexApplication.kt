package com.despaircorp.championdex.android

import android.app.Application
import android.util.Log
import com.despaircorp.championdex.sharedModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin
import org.koin.core.logger.PrintLogger

class ChampionDexApplication: Application() {
    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidContext(this@ChampionDexApplication)
            modules(sharedModule, androidModule)
            Log.i("Monokouma", PrintLogger().toString())
        }
    }
}