package com.martianlab.recipes.domain.api

import com.martianlab.recipes.entities.Category
import com.martianlab.recipes.entities.Recipe
import com.martianlab.recipes.entities.Result


/**
 * REST API access points
 */
internal interface BackendApi {

    suspend fun recipeSearch(categoryId : Long, recipeId : Long, count : Int, offset : Int ) : Result<List<Recipe>>

    suspend fun getCategories() : Result<List<Category>>

    suspend fun getCategory( categoryId : Long ) : Result<Category?>

}
