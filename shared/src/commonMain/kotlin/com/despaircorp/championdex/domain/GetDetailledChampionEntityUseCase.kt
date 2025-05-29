package com.despaircorp.championdex.domain

import Champion
import com.despaircorp.championdex.domain.entities.DetailledChampionEntity
import com.despaircorp.championdex.domain.entities.SkinEntity
import com.despaircorp.championdex.domain.entities.SpellEntity

class GetDetailledChampionEntityUseCase(
    private val apiInterface: ApiInterface
) {
    suspend fun invoke(id: String): DetailledChampionEntity? {
        return apiInterface.getDetailledChampionEntity(id)?.let { response ->
            response.data.values.firstOrNull()?.let { champion ->
                mapToDetailledChampion(champion, response.version)
            }
        }
    }
    
    private fun mapToDetailledChampion(dto: Champion, version: String): DetailledChampionEntity? {
        return try {
            DetailledChampionEntity(
                id = dto.id,
                key = dto.key,
                name = dto.name,
                title = dto.title.split(' ').joinToString(" ") { word ->
                    if (word.isNotEmpty()) word[0].uppercaseChar() + word.drop(1) else word
                },
                imageUrl = "https://ddragon.leagueoflegends.com/cdn/$version/img/champion/${dto.image.full}",
                lore = dto.lore,
                blurb = dto.blurb,
                tags = dto.tags,
                partype = dto.partype,
                attackRating = dto.info.attack,
                defenseRating = dto.info.defense,
                magicRating = dto.info.magic,
                difficultyRating = dto.info.difficulty,
                hp = dto.stats.hp,
                hpperlevel = dto.stats.hpperlevel,
                mp = dto.stats.mp,
                mpperlevel = dto.stats.mpperlevel,
                movespeed = dto.stats.movespeed,
                armor = dto.stats.armor,
                armorperlevel = dto.stats.armorperlevel,
                spellblock = dto.stats.spellblock,
                spellblockperlevel = dto.stats.spellblockperlevel,
                attackrange = dto.stats.attackrange,
                hpregen = dto.stats.hpregen,
                hpregenperlevel = dto.stats.hpregenperlevel,
                mpregen = dto.stats.mpregen,
                mpregenperlevel = dto.stats.mpregenperlevel,
                crit = dto.stats.crit,
                critperlevel = dto.stats.critperlevel,
                attackdamage = dto.stats.attackdamage,
                attackdamageperlevel = dto.stats.attackdamageperlevel,
                attackspeedperlevel = dto.stats.attackspeedperlevel,
                attackspeed = dto.stats.attackspeed,
                passiveName = dto.passive.name,
                passiveDescription = dto.passive.description,
                passiveImageUrl = "https://ddragon.leagueoflegends.com/cdn/$version/img/passive/${dto.passive.image.full}",
                spells = dto.spells.map { spell ->
                    SpellEntity(
                        id = spell.id,
                        name = spell.name,
                        description = spell.description,
                        tooltip = spell.tooltip,
                        maxrank = spell.maxrank,
                        cooldown = spell.cooldown,
                        cooldownBurn = spell.cooldownBurn,
                        cost = spell.cost,
                        costBurn = spell.costBurn,
                        costType = spell.costType,
                        range = spell.range,
                        rangeBurn = spell.rangeBurn,
                        imageUrl = "https://ddragon.leagueoflegends.com/cdn/$version/img/spell/${spell.image.full}",
                        resource = spell.resource
                    )
                },
                skins = dto.skins.map { skin ->
                    SkinEntity(
                        id = skin.id,
                        num = skin.num,
                        name = skin.name,
                        chromas = skin.chromas,
                        splashUrl = "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/${dto.id}_${skin.num}.jpg",
                        loadingUrl = "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/${dto.id}_${skin.num}.jpg"
                    )
                },
                allytips = dto.allytips,
                enemytips = dto.enemytips
            )
        } catch (e: Exception) {
            e.stackTraceToString()
            null
        }
    }
}