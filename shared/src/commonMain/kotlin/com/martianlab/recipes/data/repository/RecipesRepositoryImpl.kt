package com.martianlab.data.repository

import com.martianlab.recipes.domain.api.DbApi
import com.martianlab.recipes.domain.api.BackendApi
import com.martianlab.recipes.domain.RecipesRepository
import com.martianlab.recipes.entities.*
import kotlinx.coroutines.flow.Flow


internal class RecipesRepositoryImpl constructor(
    private val dbApi: DbApi,
    private val backendApi: BackendApi,
) : RecipesRepository {


    override suspend fun loadDb() {
        loadCategories().forEach {
            loadCategoryRecipesToDb(it)
        }
    }

    private suspend fun loadCategories() : List<Category>{
        val categoryList = getCategoriesFromBackend()
        loadCategoriesToDb(categoryList)

        return categoryList
    }


    suspend fun getRecipesFromBackend(categoryId: Long, recipeId : Long, count: Int, offset: Int): Result<List<Recipe>> =
         backendApi.recipeSearch(categoryId, 0L, count, offset)
    

    override suspend fun getRecipesFlow(): Flow<List<Recipe>> 
       = dbApi.getRecipesFlow()

    override suspend fun getRecipesFlow(tags: List<RecipeTag>): Flow<List<Recipe>> =
         dbApi.getRecipesFlow(tags[0])

    
    override suspend fun loadCategoryRecipesToDb(category : Category ){
        val count = 20
        var offset = 0
        //println("RECIPES: category=" + category)
        do {
            val result: Result<List<Recipe>> = getRecipesFromBackend(category.id, 0L, count, offset)
            if( result is Result.Success ){
                result.data?.let {list ->
                    //println("RECIPES:: res=" + list)
                    val recipeWithTagList = list.map { it.copy(tags = listOf(RecipeTag(id=category.id, recipeId = it.id, title = category.title ))) }
                    dbApi.insert(recipeWithTagList)
                }
            }
            offset += count
        }while( offset < category.total )
    }

    private suspend fun loadCategoriesToDb(categoryList: List<Category>) : List<Long>{
        return dbApi.insertCategories(categoryList)
    }
    

    override suspend fun getCategoriesFromBackend() : List<Category>{
        val result: Result<List<Category>> = backendApi.getCategories()
        val categoryList = if( result is Result.Success ){
            //println("RECIPES:: cats=" + result.data)
            result.data?.map {
                val res = backendApi.getCategory(it.id)
                if( res is Result.Success )
                    it.copy(total = res.data!!.total)
                else
                    Category(-1L, "", "", 0, 0)
            }?.filter { it.id >= 0  }.orEmpty()
        }else listOf()

        return categoryList
    }

    override suspend fun getCategoriesFlow(): Flow<List<Category>> =
            dbApi.getCategoriesFlow()
    
    

//    override suspend fun searchIngredients(contains: String): List<RecipeIngredient> = dbApi.searchIngredients(contains)
//
//    override suspend fun searchRecipes(contains: String): Flow<List<Recipe>> = dbApi.searchRecipes(contains)
//
//    override suspend fun setFavorite(recipe: Recipe) = dbApi.setFavorite(recipe)
//
//    override suspend fun removeFavorite(recipe: Recipe) = dbApi.removeFavorite(recipe)
//
//    override suspend fun getFavorites(): List<Recipe> = dbApi.getFavorites()
}


