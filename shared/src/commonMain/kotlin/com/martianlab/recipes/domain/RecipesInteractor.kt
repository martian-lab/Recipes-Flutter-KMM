package com.martianlab.recipes.domain


import com.martianlab.recipes.entities.Category
import com.martianlab.recipes.entities.Recipe
import kotlinx.coroutines.flow.Flow

interface RecipesInteractor {

    suspend fun getCategoriesFlow() : Flow<List<Category>>
    suspend fun getCategoriesAsJsonFlow() : Flow<String>
    suspend fun getRecipesFlow() : Flow<List<Recipe>>
    suspend fun getRecipesFlow(category: Category) : Flow<List<Recipe>>
    suspend fun getRecipesAsJsonFlow(category: Category? = null) : Flow<String>
    
    suspend fun updatesCheck(): Flow<Long>
    @Throws(Exception::class) suspend fun getCategoriesAsJson() : String
    @Throws(Exception::class) suspend fun getRecipesAsJson(catId: String) : String
    @Throws(Exception::class) suspend fun setUpdatesListener(listener : (Int) -> Unit)
}