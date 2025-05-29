package com.despaircorp.championdex.android

import com.despaircorp.championdex.android.view_model.MainViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val androidModule = module {
    viewModel { MainViewModel(get()) }
}