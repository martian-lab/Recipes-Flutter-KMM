package com.martianlab.recipes.entities

sealed class Destination() {
    object MainPage : Destination()
    data class RecipeDetails(val recipeId : Long) : Destination()
    object Splash : Destination()
}