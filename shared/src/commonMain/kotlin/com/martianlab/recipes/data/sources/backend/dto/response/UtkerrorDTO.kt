package com.martianlab.recipes.data.sources.backend.dto.response


import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable


@Serializable
class UtkerrorDTO(


    @SerialName("Code")
    val code: Int,

    @SerialName("Description")
    val message: String
)