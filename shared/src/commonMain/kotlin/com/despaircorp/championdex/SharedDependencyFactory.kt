package com.despaircorp.championdex

import com.despaircorp.championdex.data.ApiRepository
import com.despaircorp.championdex.domain.GetChampionsEntitiesUseCase
import com.despaircorp.championdex.domain.GetDetailledChampionEntityUseCase
import io.ktor.client.HttpClient
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.serialization.kotlinx.json.json

object SharedDependencyFactory {
    private val httpClient by lazy {
        HttpClient {
            install(ContentNegotiation) {
                json()
            }
        }
    }
    
    private val championRepository by lazy {
        ApiRepository(httpClient)
    }
    
    fun createGetChampionsUseCase(): GetChampionsEntitiesUseCase {
        return GetChampionsEntitiesUseCase(championRepository)
    }
    
    fun createGetDetailledChampionEntityUseCase(): GetDetailledChampionEntityUseCase {
        return GetDetailledChampionEntityUseCase(championRepository)
    }
}