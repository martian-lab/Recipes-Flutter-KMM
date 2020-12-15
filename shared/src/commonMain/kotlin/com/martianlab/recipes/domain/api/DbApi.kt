package com.martianlab.recipes.domain.api


import com.martianlab.recipes.entities.Category
import com.martianlab.recipes.entities.Recipe
import com.martianlab.recipes.entities.RecipeIngredient
import com.martianlab.recipes.entities.RecipeTag
import kotlinx.coroutines.flow.Flow


internal interface DbApi{

    suspend fun getRecipesFlow(tag: RecipeTag) : Flow<List<Recipe>>

    suspend fun getRecipesFlow() : Flow<List<Recipe>>

    suspend fun getRecipes(tag: RecipeTag) : List<Recipe>

    suspend fun getRecipes() : List<Recipe>

    //fun getRecipesPages(tags : List<RecipeTag>): DataSource.Factory<Int, Recipe>

    suspend fun getRecipeById(id : Long ) : Recipe

    suspend fun insert(recipe: Recipe) : Long

    suspend fun insert(recipeList : List<Recipe>)

    suspend fun loadCategories() : Flow<List<Category>>

    suspend fun getCategories() : List<Category>

    suspend fun insertCategories(categoryList: List<Category>) : List<Long>

    suspend fun searchIngredients( contains : String ) : List<RecipeIngredient>

    suspend fun searchRecipes( contains : String ) : Flow<List<Recipe>>

    suspend fun setFavorite(recipe: Recipe)

    suspend fun removeFavorite(recipe: Recipe)

    suspend fun getFavorites(): List<Recipe>

    suspend fun getRecipesByIngredient(ingredient: RecipeIngredient) : List<Recipe>


}
