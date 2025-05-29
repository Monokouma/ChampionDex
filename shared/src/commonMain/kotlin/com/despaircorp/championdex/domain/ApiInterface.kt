package com.despaircorp.championdex.domain

import ChampionDetailledResponse
import com.despaircorp.championdex.data.dto.ChampionResponse

interface ApiInterface {
    suspend fun getChampionsEntities(): ChampionResponse?
    
    suspend fun getDetailledChampionEntity(id: String): ChampionDetailledResponse?
}