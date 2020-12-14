package com.martianlab.recipes.data.sources.backend.dto.response


import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
internal class UtkoresponseDTO<B>(

    @SerialName("Head")
    val head: Head,

    @SerialName("Body")
    val body: B
) {
    @Serializable
    class Head(

        @SerialName("SessionToken")
        val accessToken: String?= null,

        @SerialName("SessionGroups")
        val sessionGroups: List<String>? = null


    )

    @Serializable
    class BaseBody(

        @SerialName("ErrorList")
        val errors: List<UtkerrorDTO>?= null
    )
}