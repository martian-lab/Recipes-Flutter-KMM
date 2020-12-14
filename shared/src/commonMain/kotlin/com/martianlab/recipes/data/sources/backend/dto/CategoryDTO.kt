package com.martianlab.recipes.data.sources.backend.dto

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable


@Serializable
internal class CategoryDTO(

    @SerialName("Id")
    val id : Long,

    @SerialName("Category")
    val category : String,

    @SerialName("Sort")
    val sort : Int,

    @SerialName("imageURL")
    val imageURL : String?= null
)