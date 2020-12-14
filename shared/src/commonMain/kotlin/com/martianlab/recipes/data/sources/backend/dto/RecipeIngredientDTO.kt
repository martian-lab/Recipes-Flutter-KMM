package com.martianlab.recipes.data.sources.backend.dto


import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable


@Serializable
internal class RecipeIngredientDTO(

    @SerialName("Id")
    val id : Long,

    @SerialName("RecipeId")
    val recipeId : Long,

    @SerialName("Name")
    val name : String,

    @SerialName("HowMany")
    val quantity : String,

    @SerialName("HowManyUnit")
    val measureUnit : String,

    @SerialName("Position")
    val position : Int
)


