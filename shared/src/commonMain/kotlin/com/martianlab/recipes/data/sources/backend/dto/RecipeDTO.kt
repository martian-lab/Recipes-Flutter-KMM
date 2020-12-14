package com.martianlab.recipes.data.sources.backend.dto


import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
internal class RecipeDTO(

    @SerialName("Id")
    val id : Int,

    @SerialName("Url")
    val url : String, //"/recipe/3517",

    @SerialName("Name")
    val name : String,

    @SerialName("Complexity")
    val complexity : Int,

    @SerialName("NumberPersons")
    val numberPersons : Int,

    @SerialName("Image")
    val imageURL : String,

    @SerialName("ViewImage")
    val viewImageURL : String,

    @SerialName("Description")
    val description : String,// "",

    @SerialName("Comment")
    val comments : List<CommentDTO>,

    @SerialName("Rating")
    val rating : RatingDTO? = null
)

@Serializable
class RatingDTO(

    @SerialName("Rate")
    val rate : Int,

    @SerialName("Votes")
    val votes : Int
)
