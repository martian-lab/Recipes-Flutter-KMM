package com.martianlab.example.my_flutter_app

import androidx.lifecycle.ViewModel
import com.martianlab.recipes.domain.RecipesInteractor
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import kotlinx.coroutines.flow.collect

class RecipesViewModel(
        val interactor: RecipesInteractor,
        val channel : MethodChannel
) : ViewModel(), CoroutineScope by CoroutineScope(Dispatchers.IO){

    init{
//        launch {
//            interactor.firstLaunchCheck()
//            interactor.getCategoriesAsJsonFlow().collect {
//                withContext(Dispatchers.Main) {
//                    channel.invokeMethod("updateCategoryList", it)
//                }
//            }
//        }
        launch {
            interactor.getCategories().forEach { category ->
                launch {
                    interactor.getRecipesAsJsonFlow(category).collect {
                        withContext(Dispatchers.Main) {
                            channel.invokeMethod("updateRecipeList", mapOf("categoryId" to category.id, "recipeList" to it))
                        }
                    }
                }
            }
        }


        channel.setMethodCallHandler { call, result ->
            println("flutter_srv: method=" + call.method + " args=" + call.arguments)

            launch{
                try {
                    val res = interactor.getCategoriesList()
                    withContext(Dispatchers.Main) { result.success(res) }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) { result.error("N/A",
                            "Error during firstLaunchCheck().",
                            e.localizedMessage)}
                }
            }
        }

    }
    
    
}