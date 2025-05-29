package com.despaircorp.championdex.data.dto

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class ChampionResponse(
    @SerialName("data")
    val data: Map<String, ChampionDto>? = null,
    
    @SerialName("format")
    val format: String? = null,
    
    @SerialName("type")
    val type: String? = null,
    
    @SerialName("version")
    val version: String? = null
)

@Serializable
data class ChampionDto(
    @SerialName("image")
    val image: Image? = null,
    
    @SerialName("stats")
    val stats: Stats? = null,
    
    @SerialName("partype")
    val partype: String? = null,
    
    @SerialName("name")
    val name: String? = null,
    
    @SerialName("id")
    val id: String? = null,
    
    @SerialName("title")
    val title: String? = null,
    
    @SerialName("blurb")
    val blurb: String? = null,
    
    @SerialName("version")
    val version: String? = null,
    
    @SerialName("key")
    val key: String? = null,
    
    @SerialName("info")
    val info: Info? = null,
    
    @SerialName("tags")
    val tags: List<String?>? = null
)

@Serializable
data class Stats(
    @SerialName("mpregen")
    val mpregen: Double? = null,
    
    @SerialName("attackdamageperlevel")
    val attackdamageperlevel: Double? = null,
    
    @SerialName("mp")
    val mp: Int? = null,
    
    @SerialName("attackrange")
    val attackrange: Int? = null,
    
    @SerialName("hpperlevel")
    val hpperlevel: Int? = null,
    
    @SerialName("hp")
    val hp: Int? = null,
    
    @SerialName("hpregen")
    val hpregen: Double? = null,
    
    @SerialName("mpregenperlevel")
    val mpregenperlevel: Double? = null,
    
    @SerialName("spellblock")
    val spellblock: Int? = null,
    
    @SerialName("critperlevel")
    val critperlevel: Int? = null,
    
    @SerialName("movespeed")
    val movespeed: Int? = null,
    
    @SerialName("mpperlevel")
    val mpperlevel: Double? = null,
    
    @SerialName("armor")
    val armor: Int? = null,
    
    @SerialName("armorperlevel")
    val armorperlevel: Double? = null,
    
    @SerialName("crit")
    val crit: Int? = null,
    
    @SerialName("attackdamage")
    val attackdamage: Int? = null,
    
    @SerialName("attackspeed")
    val attackspeed: Double? = null,
    
    @SerialName("spellblockperlevel")
    val spellblockperlevel: Double? = null,
    
    @SerialName("attackspeedperlevel")
    val attackspeedperlevel: Double? = null,
    
    @SerialName("hpregenperlevel")
    val hpregenperlevel: Double? = null
)

@Serializable
data class Info(
    @SerialName("magic")
    val magic: Int? = null,
    
    @SerialName("difficulty")
    val difficulty: Int? = null,
    
    @SerialName("defense")
    val defense: Int? = null,
    
    @SerialName("attack")
    val attack: Int? = null
)

@Serializable
data class Image(
    @SerialName("w")
    val w: Int? = null,
    
    @SerialName("sprite")
    val sprite: String? = null,
    
    @SerialName("x")
    val x: Int? = null,
    
    @SerialName("h")
    val h: Int? = null,
    
    @SerialName("y")
    val y: Int? = null,
    
    @SerialName("full")
    val full: String? = null,
    
    @SerialName("group")
    val group: String? = null
)