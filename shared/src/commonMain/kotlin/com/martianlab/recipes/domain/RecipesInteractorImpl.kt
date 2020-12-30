package com.martianlab.recipes.domain

import com.martianlab.recipes.entities.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json


internal class RecipesInteractorImpl constructor(
    private val recipesRepository: RecipesRepository
) : RecipesInteractor{

    private val serializer = Json { isLenient = true; ignoreUnknownKeys = true }
//
//    override fun onBackPressed() {
//        router.goBack()
//    }
//
//    override fun goTo(destination: Destination){
//        router.goTo(destination)
//    }

//    override suspend fun loadToDb() {
//        recipesRepository.loadRecipesToDb()
//    }

    // called from Kotlin/Native clients
    override suspend fun getCategoriesAsJson() : String =
        getCategoriesAsJsonFlow().first()
    

    // called from Kotlin/Native clients
    override suspend fun getRecipesAsJson(catId: String) : String {
        val category = getCategoriesFlow().first().find{ it.id == catId.toLong() }
        return category?.let{
            return getRecipesAsJsonFlow(category).first()
        } ?: ""
    }

    // called from Kotlin/Native clients
    fun firstLaunchCheck_(){
        GlobalScope.launch{
            if( recipesRepository.getCategoriesFlow().first().isEmpty() ){
                recipesRepository.loadDb()
            }
        }
    }

    override suspend fun getCategoriesFlow(): Flow<List<Category>> {
        return recipesRepository.getCategoriesFlow()
    }

    override suspend fun getCategoriesAsJsonFlow(): Flow<String> 
        = getCategoriesFlow().map { serializer.encodeToString(it) }

    override suspend fun getRecipesFlow(): Flow<List<Recipe>> {
        return recipesRepository.getRecipesFlow()
    }

    override suspend fun getRecipesFlow(category: Category): Flow<List<Recipe>> {
        val tags = listOf(RecipeTag(category.id, 0L, category.title))
        return recipesRepository.getRecipesFlow(tags)
    }

    override suspend fun getRecipesAsJsonFlow(category: Category?): Flow<String> =
            run{
                category?.let { getRecipesFlow(category) } ?: getRecipesFlow() 
            }.map { serializer.encodeToString(it) }
    
    

    override suspend fun updatesCheck() : Flow<Long>{
        return flow{
            recipesRepository.getCategoriesFromBackend()
                    .filter { it.total != getRecipesFlow(it).first().size }
                    .forEach { recipesRepository.loadCategoryRecipesToDb(it); emit(it.id) }
        }
    }

    override suspend fun setUpdatesListener(listener: (Int) -> Unit) {
        updatesCheck().collect {
            withContext(Dispatchers.Main) {
                listener(it.toInt())
            }
        }
    }

    //    override suspend fun searchIngredients(contains: String): List<RecipeIngredient> = recipesRepository.searchIngredients(contains)
//    override suspend fun searchRecipes(contains: String): Flow<List<Recipe>> = recipesRepository.searchRecipes(contains)
//    override suspend fun setFavorite(recipe: Recipe) = recipesRepository.setFavorite(recipe)
//    override suspend fun removeFavorite(recipe: Recipe) = recipesRepository.removeFavorite(recipe)
//    override suspend fun getFavorites(): List<Recipe> = recipesRepository.getFavorites()
}