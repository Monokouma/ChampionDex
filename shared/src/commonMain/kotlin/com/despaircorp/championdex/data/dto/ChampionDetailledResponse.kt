import kotlinx.serialization.Serializable

@Serializable
data class ChampionDetailledResponse(
    val type: String,
    val format: String,
    val version: String,
    val data: Map<String, Champion>
)

@Serializable
data class Champion(
    val id: String,
    val key: String,
    val name: String,
    val title: String,
    val image: ChampionImage,
    val skins: List<ChampionSkin>,
    val lore: String,
    val blurb: String,
    val allytips: List<String>,
    val enemytips: List<String>,
    val tags: List<String>,
    val partype: String,
    val info: ChampionInfo,
    val stats: ChampionStats,
    val spells: List<ChampionSpell>,
    val passive: ChampionPassive,
    val recommended: List<String> = emptyList()
)

@Serializable
data class ChampionImage(
    val full: String,
    val sprite: String,
    val group: String,
    val x: Int,
    val y: Int,
    val w: Int,
    val h: Int
)

@Serializable
data class ChampionSkin(
    val id: String,
    val num: Int,
    val name: String,
    val chromas: Boolean
)

@Serializable
data class ChampionInfo(
    val attack: Int,
    val defense: Int,
    val magic: Int,
    val difficulty: Int
)

@Serializable
data class ChampionStats(
    val hp: Double,
    val hpperlevel: Double,
    val mp: Double,
    val mpperlevel: Double,
    val movespeed: Double,
    val armor: Double,
    val armorperlevel: Double,
    val spellblock: Double,
    val spellblockperlevel: Double,
    val attackrange: Double,
    val hpregen: Double,
    val hpregenperlevel: Double,
    val mpregen: Double,
    val mpregenperlevel: Double,
    val crit: Double,
    val critperlevel: Double,
    val attackdamage: Double,
    val attackdamageperlevel: Double,
    val attackspeedperlevel: Double,
    val attackspeed: Double
)

@Serializable
data class ChampionSpell(
    val id: String,
    val name: String,
    val description: String,
    val tooltip: String,
    val leveltip: SpellLevelTip,
    val maxrank: Int,
    val cooldown: List<Double>,
    val cooldownBurn: String,
    val cost: List<Double>,
    val costBurn: String,
    val datavalues: Map<String, String> = emptyMap(),
    val effect: List<List<Double>?>,
    val effectBurn: List<String?>,
    val vars: List<SpellVar> = emptyList(),
    val costType: String,
    val maxammo: String,
    val range: List<Double>,
    val rangeBurn: String,
    val image: ChampionImage,
    val resource: String
)

@Serializable
data class SpellLevelTip(
    val label: List<String>,
    val effect: List<String>
)

@Serializable
data class SpellVar(
    val link: String? = null,
    val coeff: List<Double>? = null,
    val key: String? = null
)

@Serializable
data class ChampionPassive(
    val name: String,
    val description: String,
    val image: ChampionImage
)