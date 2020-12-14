package com.martianlab.data.repository

import com.martianlab.recipes.domain.api.DbApi
import com.martianlab.recipes.domain.api.BackendApi
import com.martianlab.recipes.domain.RecipesRepository
import com.martianlab.recipes.entities.*
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow


internal class RecipesRepositoryImpl constructor(
    private val dbApi: DbApi,
    private val backendApi: BackendApi,
    //private val preferences: SharedPreferences
) : RecipesRepository {


    override suspend fun loadDb() {
        val categoryList = loadCategories()
        categoryList.forEach {
            loadCategoryRecipesToDb(it)
        }
    }

    private suspend fun loadCategories() : List<Category>{
        val categoryList = getCategoriesFromBackend()
        loadCategoriesToDb(categoryList)

        return categoryList
    }


    override suspend fun getRecipesFromBackend(count: Int, offset: Int): Result<List<Recipe>> {
        return backendApi.recipeSearch(0L, 0L, count, offset)
    }

    override suspend fun insertRecipes(recipes: List<Recipe>) {
        dbApi.insert(recipes)
    }

//    override fun loadRecipesPaged(tags : List<RecipeTag>): LiveData<PagedList<Recipe>> {
//        val config = PagedList.Config.Builder()
//            .setEnablePlaceholders(false)
//            .setPageSize(10)
//            .build()
//        return dbApi.getRecipesPages(tags).toLiveData(config)
//    }

    override suspend fun loadRecipes(): Flow<List<Recipe>> {
        val recipes = dbApi.getRecipes()//.also { it.forEach {  println("RECIPES:::: recipe=" + it ) } }
        //println("RECIPES: from db size=" + recipes.size )
//        if( recipes.isEmpty() ){
//            loadRecipesFromFile().also {
//                insertRecipes(it)
//                return@loadRecipes it
//            }
//        }
        return recipes//.also{ it.forEach { println("RECIPES: loaded=" + it ) } }
    }

    override suspend fun loadRecipes(tags: List<RecipeTag>): Flow<List<Recipe>> {
        val recipes = dbApi.getRecipes(tags[0])
        //println("RECIPES: from db size=" + recipes.ize )
//        if( recipes.isEmpty() ){
////            loadRecipesFromFile().also {
////                insertRecipes(it)
////                return@loadRecipes it
////            }
//            getCategoriesFromBackend().forEach { loadCategoryRecipesToDb(it) }
//            //loadCategoriesFromFile().forEach { loadCategoryRecipesToDb(it) }
//            return dbApi.getRecipes(tags[0])
//        }
        return recipes//.also{ it.forEach { println("RECIPES: loaded=" + it ) } }
    }

//    private fun loadRecipesFromFile() : List<Recipe>{
//        val json = RecipesRepositoryImpl::class.java.classLoader?.getResource("mytextfile.json")?.readText()
//        val recipeListTypeToken = object : TypeToken<List<Recipe>>() {}.type
//        val gson: Gson = GsonBuilder().setDateFormat("MMM dd, yyyy HH:mm:ss").create()
//        val recipeList: List<Recipe> = gson.fromJson(json, recipeListTypeToken)
//        return recipeList
//    }
//
//    private fun loadCategoriesFromFile() : List<Category>{
//        val json = RecipesRepositoryImpl::class.java.classLoader?.getResource("categories.json")?.readText()
//        val categoryListTypeToken = object : TypeToken<List<Category>>() {}.type
//        val categoryList: List<Category> = Gson().fromJson(json, categoryListTypeToken)
//        return categoryList
//    }

    override suspend fun getRecipe(id: Long): Recipe? {
        return dbApi.getRecipeById(id)
    }

    override suspend fun getRecipesByIngredients(ingredients: List<RecipeIngredient>): List<Recipe> =
        dbApi.getRecipesByIngredient(ingredients[0])
            .filter { it.ingredients.containsAll(ingredients) }


    private suspend fun loadCategoryRecipesToDb(category : Category ){
        val count = 20
        var offset = 0
        println("RECIPES: category=" + category)
        do {
            val result = backendApi.recipeSearch(category.id, 0L, count, offset )
            if( result is Result.Success ){
                result.data?.let {list ->
                    println("RECIPES:: res=" + list)
                    val recipeWithTagList = list.map { it.copy(tags = listOf(RecipeTag(id=category.id, recipeId = it.id, title = category.title ))) }
                    //println("RECIPES:: firts cat recipe=" + recipeWithTagList[0].tags )
                    dbApi.insert(recipeWithTagList)
//                    println("RECIPES: list=" + recipeWithTagList )
//                    list.forEach {
//                        val tag = RecipeTag(id=category.id, recipeId = it.id, title = category.title )
//                        val recipe = it.copy(tags = setOf(tag))
//                        dbApi.insert(recipe)
//                    }
                }
            }
            offset += count
        }while( offset < 1/*category.total*/ )
    }

    private suspend fun loadCategoriesToDb(categoryList: List<Category>) : List<Long>{
        return dbApi.insertCategories(categoryList)
    }

    override suspend fun loadRecipesToDb(){
            val categoryList = getCategoriesFromBackend()

            loadCategoriesToDb(categoryList).also { println("RECIPES: catIds=" + it) }
            //categoryList.forEach { loadCategoryRecipesToDb(it) }
    }


    override suspend fun loadRecipesToDbFlow() : Flow<String> {
        return flow {
            val categoryList = getCategoriesFromBackend()
            emit("getting category list")
            loadCategoriesToDb(categoryList)
            emit("loading categories into db")
            categoryList.forEach {
                loadCategoryRecipesToDb(it)
                emit("loading category ${it.title}" )
            }
        }
    }
    
    override suspend fun getCategories() : List<Category>
        = dbApi.getCategories()

    private suspend fun getCategoriesFromBackend() : List<Category>{
        val result = backendApi.getCategories()
        val categoryList = if( result is Result.Success ){
            println("RECIPES:: cats=" + result.data)
            result.data?.map {
                //println("RECIPES:: cat=" + it)
                val res = backendApi.getCategory(it.id)
                //println("RECIPES:: catres=" + res)
                if( res is Result.Success )
                    it.copy(total = res.data!!.total)
                    //res.data!!
                else
                    Category(-1L, "", "", 0, 0)
            }?.filter { it.id >= 0  }.orEmpty()
        }else listOf()

        return categoryList
    }

    override suspend fun loadCategoriesFromDb(): Flow<List<Category>> {
//        loadCategoriesToDb(getCategoriesFromBackend())
        val categories = dbApi.loadCategories()
//        println("RECIPES: categories from db size=" + categories.size )
//        if( categories.isEmpty() ){
//            getCategoriesFromBackend()
//            //loadCategoriesFromFile()
//                .also {
//                dbApi.insertCategories(it)
//                it.forEach { loadCategoryRecipesToDb(it) }
//                return it
//            }
//        }
        return categories
        //return dbApi.loadCategories()
    }

    suspend fun getRecipesTotal() : Long{
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }


    override suspend fun searchIngredients(contains: String): List<RecipeIngredient> = dbApi.searchIngredients(contains)

    override suspend fun searchRecipes(contains: String): Flow<List<Recipe>> = dbApi.searchRecipes(contains)

    override suspend fun setFavorite(recipe: Recipe) = dbApi.setFavorite(recipe)

    override suspend fun removeFavorite(recipe: Recipe) = dbApi.removeFavorite(recipe)

    override suspend fun getFavorites(): List<Recipe> = dbApi.getFavorites()
}


