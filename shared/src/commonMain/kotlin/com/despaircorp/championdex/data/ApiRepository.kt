package com.despaircorp.championdex.data

import ChampionDetailledResponse
import com.despaircorp.championdex.data.dto.ChampionResponse
import com.despaircorp.championdex.domain.ApiInterface
import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.request.get
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.IO
import kotlinx.coroutines.ensureActive
import kotlinx.coroutines.withContext

class ApiRepository(
    private val httpClient: HttpClient
) : ApiInterface {
    
    override suspend fun getChampionsEntities(): ChampionResponse? =
        withContext(Dispatchers.IO) {
            try {
                val championsDto = httpClient
                    .get("https://ddragon.leagueoflegends.com/cdn/15.10.1/data/en_US/champion.json")
                    .body<ChampionResponse>()
                championsDto
            } catch (e: Exception) {
                ensureActive()
                println(e.stackTraceToString())
                null
            }
        }
    
    override suspend fun getDetailledChampionEntity(id: String): ChampionDetailledResponse? =
        withContext(
            Dispatchers.IO
        ) {
            try {
                val championDetailledDto = httpClient
                    .get("https://ddragon.leagueoflegends.com/cdn/15.11.1/data/en_US/champion/${id}.json")
                    .body<ChampionDetailledResponse>()
                
                championDetailledDto
            } catch (e: Exception) {
                ensureActive()
                println(e.stackTraceToString())
                null
            }
        }
}