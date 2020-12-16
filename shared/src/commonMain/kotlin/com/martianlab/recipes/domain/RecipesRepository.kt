package com.martianlab.recipes.domain

import com.martianlab.recipes.entities.*
import kotlinx.coroutines.flow.Flow

internal interface RecipesRepository {

    //suspend fun getRecipesFromBackend(count : Int, offset : Int ) : Result<List<Recipe>>

    //suspend fun insertRecipes(recipes: List<Recipe>)

    suspend fun getRecipesFlow() : Flow<List<Recipe>>
    suspend fun getRecipesFlow(tags : List<RecipeTag>) : Flow<List<Recipe>>

    //suspend fun loadRecipes() : List<Recipe>

    //suspend fun loadRecipes(tags : List<RecipeTag>) : List<Recipe>

    //suspend fun getRecipe( id : Long ) : Recipe?

    //suspend fun getRecipesByIngredients( ingredients: List<RecipeIngredient> ) : List<Recipe>

    //suspend fun loadRecipesToDb()

    suspend fun getCategoriesFlow() : Flow<List<Category>>

    //suspend fun loadRecipesToDbFlow() : Flow<String>
    
    //suspend fun searchIngredients( contains : String ) : List<RecipeIngredient>
    //suspend fun searchRecipes( contains : String ) : Flow<List<Recipe>>
    //suspend fun setFavorite(recipe: Recipe)
    //suspend fun removeFavorite(recipe: Recipe)
    //suspend fun getFavorites(): List<Recipe>
    //suspend fun getCategories(): List<Category>
    
    suspend fun loadDb()
}