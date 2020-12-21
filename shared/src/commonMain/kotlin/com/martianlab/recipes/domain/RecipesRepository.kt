package com.martianlab.recipes.domain

import com.martianlab.recipes.entities.*
import kotlinx.coroutines.flow.Flow

internal interface RecipesRepository {

    suspend fun getRecipesFlow() : Flow<List<Recipe>>
    suspend fun getRecipesFlow(tags : List<RecipeTag>) : Flow<List<Recipe>>
    suspend fun getCategoriesFlow() : Flow<List<Category>>
    suspend fun loadDb()
    suspend fun getCategoriesFromBackend(): List<Category>
    suspend fun loadCategoryRecipesToDb(category: Category)
}