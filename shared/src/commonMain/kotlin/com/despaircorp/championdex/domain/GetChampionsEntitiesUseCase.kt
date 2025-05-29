package com.despaircorp.championdex.domain

import com.despaircorp.championdex.data.dto.ChampionDto
import com.despaircorp.championdex.domain.entities.ChampionEntity

class GetChampionsEntitiesUseCase(
    private val apiInterface: ApiInterface
) {
    suspend fun invoke(): List<ChampionEntity> =
        apiInterface.getChampionsEntities()?.data?.values?.mapNotNull { championDto ->
            mapToChampion(championDto)
        } ?: emptyList()
    
    private fun mapToChampion(dto: ChampionDto): ChampionEntity? {
        return try {
            
            ChampionEntity(
                id = dto.id ?: return null,
                name = dto.name ?: return null,
                title = dto.title.let {
                    it?.split(' ')?.joinToString(" ") { word ->
                        if (word.isNotEmpty()) word[0].uppercaseChar() + word.drop(1) else word
                    } ?: ""
                },
                blurb = dto.blurb ?: "",
                tags = dto.tags?.filterNotNull() ?: emptyList(),
                horizontalImageUrl = "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/${dto.id}_0.jpg",
                verticalImageUrl = "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/${dto.id}_0.jpg",
                difficulty = dto.info?.difficulty ?: 0,
                attack = dto.info?.attack ?: 0,
                defense = dto.info?.defense ?: 0,
                magic = dto.info?.magic ?: 0,
                hp = dto.stats?.hp ?: 0,
                mp = dto.stats?.mp ?: 0,
                armor = dto.stats?.armor ?: 0,
                attackDamage = dto.stats?.attackdamage ?: 0,
                movementSpeed = dto.stats?.movespeed ?: 0,
                key = dto.key ?: "0"
            )
        } catch (e: Exception) {
            e.stackTraceToString()
            null
        }
    }
}