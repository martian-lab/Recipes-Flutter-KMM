package com.martianlab.recipes.flutter

import androidx.lifecycle.ViewModel
import com.martianlab.recipes.domain.RecipesInteractor
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import kotlinx.coroutines.flow.first

class RecipesViewModel(
        val interactor: RecipesInteractor,
        val channel : MethodChannel
) : ViewModel(), CoroutineScope by CoroutineScope(Dispatchers.IO){

    init{
        launch {
            interactor.firstLaunchCheck()
            withContext(Dispatchers.Main) {
                    channel.invokeMethod("updateCategoryList", null)
            }
        }
//            interactor.getCategoriesAsJsonFlow().collect {
//                withContext(Dispatchers.Main) {
//                    channel.invokeMethod("updateCategoryList", it)
//                }
//            }
//        }
//        launch {
//            interactor.getCategories().forEach { category ->
//                launch {
//                    val cats = interactor.getCategories()
//                    interactor.getRecipesAsJsonFlow(cats[3]).collect {
//                        withContext(Dispatchers.Main) {
//                            channel.invokeMethod("updateRecipeList", mapOf("categoryId" to 0, "recipeList" to it))
//                        }
//                    }
//                }
 //           }
 //       }


        channel.setMethodCallHandler { call, result ->

            when( call.method ) {

                "getCategories" ->
                    launch {
                        try {
                            val res = interactor.getCategoriesAsJsonFlow().first()
                            withContext(Dispatchers.Main) {result.success(res)}
                        } catch (e: Exception) {
                            withContext(Dispatchers.Main) {result.error("N/A", "Error during getCategories().", e.localizedMessage)}
                        }
                    }
                "getRecipesByCategory" ->
                    launch {
                        try {
                            val catId = call.arguments as Int
                            val category = interactor.getCategoriesFlow().first().find { it.id == catId.toLong() }
                            category?.let {
                                val res = interactor.getRecipesAsJsonFlow(it).first()
                                withContext(Dispatchers.Main) {result.success(res)}
                            }
                        } catch (e: Exception) {
                            withContext(Dispatchers.Main) {result.error("N/A", "Error during getRecipesByCategory().", e.localizedMessage)}
                        }
                    }
            }
        }

    }
    
    
}