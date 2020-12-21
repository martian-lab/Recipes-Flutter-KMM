package com.martianlab.recipes.domain


import com.martianlab.recipes.entities.Category
import com.martianlab.recipes.entities.Destination
import com.martianlab.recipes.entities.Recipe
import com.martianlab.recipes.entities.RecipeIngredient
import kotlinx.coroutines.flow.Flow

interface RecipesInteractor {

    suspend fun getCategoriesFlow() : Flow<List<Category>>
    suspend fun getCategoriesAsJsonFlow() : Flow<String>
    suspend fun getRecipesFlow() : Flow<List<Recipe>>
    suspend fun getRecipesFlow(category: Category) : Flow<List<Recipe>>
    suspend fun getRecipesAsJsonFlow(category: Category? = null) : Flow<String>
    
    suspend fun updatesCheck(): Flow<Long>
    fun getCategoriesAsJson(success: (String) -> Unit)
    fun getRecipesAsJson(category: Category, success: (String) -> Unit)
    fun firstLaunchCheck_()
}