package com.despaircorp.championdex

import com.despaircorp.championdex.data.ApiRepository
import com.despaircorp.championdex.domain.ApiInterface
import com.despaircorp.championdex.domain.GetChampionsEntitiesUseCase
import com.despaircorp.championdex.domain.GetDetailledChampionEntityUseCase
import io.ktor.client.HttpClient
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.serialization.kotlinx.json.json
import org.koin.dsl.module

val sharedModule = module {
    single<HttpClient> {
        HttpClient {
            install(ContentNegotiation) {
                json()
            }
        }
    }
    
    single<ApiInterface> { ApiRepository(get()) }
    
    single { GetChampionsEntitiesUseCase(get()) }
    
    single { GetDetailledChampionEntityUseCase(get()) }
}