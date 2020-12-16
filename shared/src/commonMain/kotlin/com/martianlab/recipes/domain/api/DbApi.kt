package com.martianlab.recipes.domain.api


import com.martianlab.recipes.entities.Category
import com.martianlab.recipes.entities.Recipe
import com.martianlab.recipes.entities.RecipeIngredient
import com.martianlab.recipes.entities.RecipeTag
import kotlinx.coroutines.flow.Flow


internal interface DbApi{

    suspend fun getRecipesFlow(tag: RecipeTag) : Flow<List<Recipe>>

    suspend fun getRecipesFlow() : Flow<List<Recipe>>

    suspend fun getRecipeById(id : Long ) : Recipe

    suspend fun insert(recipeList : List<Recipe>)

    suspend fun getCategoriesFlow() : Flow<List<Category>>

    suspend fun insertCategories(categoryList: List<Category>) : List<Long>



}
