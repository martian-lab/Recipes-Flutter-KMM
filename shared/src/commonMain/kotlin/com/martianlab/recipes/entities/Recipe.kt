package com.martianlab.recipes.entities

import kotlinx.datetime.DateTimeUnit


data class Recipe(
    val id : Long,
    val title : String,
    val text: String,
    val imageURL: String,
    val complexity : Int,
    val personCount : Int,
    val rating : Double?,
    val ratingVotes : Int?,
    val tags: List<RecipeTag>,
    val stages : List<RecipeStage>,
    val ingredients : List<RecipeIngredient>,
    val comments: List<RecipeComment>
)


data class RecipeStage(
    val id : Long,
    val recipeId : Long,
    val imageURL : String,
    val text : String,
    val step : Int
)

data class RecipeIngredient(
    val id : Long,
    val recipeId : Long,
    val title : String,
    val quantity : String,
    val measureUnit : String,
    val position : Int
)

data class RecipeComment(
    val id : Long,
    val recipeId : Long,
    val authorId : Long,
    val authorName : String,
    val date: String,
    val text: String,
    val parentCommentId : Long?,
    val photoURLs : List<String>?
)

data class RecipeTag(
    val id: Long,
    val recipeId : Long,
    val title: String
)