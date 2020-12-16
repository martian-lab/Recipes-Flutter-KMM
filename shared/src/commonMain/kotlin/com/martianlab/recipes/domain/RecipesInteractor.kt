package com.martianlab.recipes.domain

//import androidx.lifecycle.LiveData
//import androidx.paging.PagedList
import com.martianlab.recipes.entities.Category
import com.martianlab.recipes.entities.Destination
import com.martianlab.recipes.entities.Recipe
import com.martianlab.recipes.entities.RecipeIngredient
import kotlinx.coroutines.flow.Flow

interface RecipesInteractor {
    fun goTo( destination: Destination)


    //suspend fun getCategories() : List<Category>
    suspend fun getCategoriesFlow() : Flow<List<Category>>
    suspend fun getCategoriesAsJsonFlow() : Flow<String>
    //suspend fun getCategoriesAsJson() : String

    suspend fun getRecipesFlow() : Flow<List<Recipe>>
    suspend fun getRecipesFlow(category: Category) : Flow<List<Recipe>>
    suspend fun getRecipesAsJsonFlow(category: Category? = null) : Flow<String>
    //suspend fun getRecipesAsJson(category: Category? = null) : String

//    suspend fun loadToDb()
    
//    suspend fun loadToDbFlow() : Flow<String>

//    suspend fun getRecipe(id:Long) : Recipe?
    //fun getRecipesPaged(category: Category) : LiveData<PagedList<Recipe>>



//    suspend fun searchIngredients(contains: String): List<RecipeIngredient>
//    suspend fun searchRecipes(contains: String): Flow<List<Recipe>>
//    suspend fun setFavorite(recipe: Recipe)
//    suspend fun removeFavorite(recipe: Recipe)
//    suspend fun getFavorites(): List<Recipe>
    fun onBackPressed()
    
    suspend fun firstLaunchCheck()
}