package com.despaircorp.championdex.domain.entities

data class ChampionEntity(
    val id: String,
    val name: String,
    val title: String,
    val blurb: String,
    val tags: List<String>,
    val horizontalImageUrl: String,
    val verticalImageUrl: String,
    val difficulty: Int,
    val attack: Int,
    val defense: Int,
    val magic: Int,
    val hp: Int,
    val mp: Int,
    val armor: Int,
    val attackDamage: Int,
    val movementSpeed: Int,
    val key: String
)