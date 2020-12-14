package com.martianlab.recipes.data.sources.backend.dto


import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable


@Serializable
internal class CommentDTO(


    @SerialName("Author")
    val author : String, // "Ольга Владимировна",

    @SerialName("Created")
    val  createdAt : String, //"2015-07-26 14:19:52",

    @SerialName("Id")
    val id : Long, // "58679",

    @SerialName("ParentId")
    val parentId : Long, // "0",

    @SerialName("RateUp")
    val rateUp : Int, // "3",

    @SerialName("RateDown")
    val rateDown : Int, // "0",

    @SerialName("Text")
    val text : String, // "Попробовала приготовить- очень вкусно получилось, прикупила бульон в желе и гренки... Я только немного твердого тертого сыра добавила в самом конце готовки.",

    @SerialName("UserPic")
    val userPic : String?= null,

    @SerialName("SelfCommentRate")
    val selfCommentRate : String
)