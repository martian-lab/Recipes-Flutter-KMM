package com.martianlab.recipes.domain

import com.martianlab.recipes.domain.api.BackendApi
import com.martianlab.recipes.domain.api.DbApi
import com.martianlab.recipes.domain.api.RoutingApi
import com.martianlab.recipes.entities.*
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json


internal class RecipesInteractorImpl constructor(
    private val recipesRepository: RecipesRepository,
    private val dbApi: DbApi,
    private val backendApi: BackendApi,
    private val router : RoutingApi
) : RecipesInteractor{

    private val serializer = Json { isLenient = true; ignoreUnknownKeys = true }
    
    override fun onBackPressed() {
        router.goBack()
    }

    override fun goTo(destination: Destination){
        router.goTo(destination)
    }

    override suspend fun loadToDb() {
        recipesRepository.loadRecipesToDb()
    }

    override suspend fun getCategoriesFlow(): Flow<List<Category>> {
        return recipesRepository.loadCategoriesFromDb()
    }

    override suspend fun getCategories(): List<Category> {
        return recipesRepository.getCategories()
    }

    override suspend fun getCategoriesAsJson() : String = 
            serializer.encodeToString(recipesRepository.getCategories())

    override suspend fun getCategoriesAsJsonFlow(): Flow<String> 
        = getCategoriesFlow().map { serializer.encodeToString(it) }

    override suspend fun getRecipesAsJson(category: Category?): String {
        return serializer.encodeToString(
                category?.let { 
                            recipesRepository.loadRecipes(listOf(RecipeTag(category.id, 0L, category.title))) } ?: 
                            recipesRepository.loadRecipes()
        )
    }

    override suspend fun loadToDbFlow(): Flow<String> {
        return recipesRepository.loadRecipesToDbFlow()
    }

    override suspend fun getRecipesFlow(): Flow<List<Recipe>> {
        return recipesRepository.loadRecipesFlow()
    }

    override suspend fun getRecipesFlow(category: Category): Flow<List<Recipe>> {
        val tags = listOf(RecipeTag(category.id, 0L, category.title))
        return recipesRepository.loadRecipesFlow(tags)
    }

    override suspend fun getRecipesAsJsonFlow(category: Category?): Flow<String> =
            run{
                category?.let { getRecipesFlow(category) } ?: getRecipesFlow() 
            }.map { serializer.encodeToString(it) }
    
    
    //    override fun getRecipesPaged(category: Category): LiveData<PagedList<Recipe>> {
//        val tags = listOf(RecipeTag(category.id, 0L, category.title))
//        return recipesRepository.loadRecipesPaged(tags)
//    }


    override suspend fun getRecipe(id: Long): Recipe? {
        return recipesRepository.getRecipe(id)
    }

    override suspend fun firstLaunchCheck() {
        //if( recipesRepository.getCategories().isEmpty() ){
            recipesRepository.loadDb()
        //}
    }

    override suspend fun searchIngredients(contains: String): List<RecipeIngredient> = recipesRepository.searchIngredients(contains)
    override suspend fun searchRecipes(contains: String): Flow<List<Recipe>> = recipesRepository.searchRecipes(contains)
    override suspend fun setFavorite(recipe: Recipe) = recipesRepository.setFavorite(recipe)
    override suspend fun removeFavorite(recipe: Recipe) = recipesRepository.removeFavorite(recipe)
    override suspend fun getFavorites(): List<Recipe> = recipesRepository.getFavorites()
}