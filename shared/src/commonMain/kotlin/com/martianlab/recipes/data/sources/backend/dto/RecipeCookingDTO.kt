package com.martianlab.recipes.tools.backend.dto


import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
class RecipeCookingDTO (

    @SerialName("Id")
    val id : Long,

    @SerialName("RecipeId")
    val recipeId : Long,

    @SerialName("Image")
    val imageURL : String,

    @SerialName("Description")
    val description : String,

    @SerialName("Position")
    val position : Int
)