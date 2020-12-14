package com.martianlab.recipes.data.sources.backend.dto.response


import com.martianlab.recipes.data.sources.backend.dto.CategoryDTO
import com.martianlab.recipes.tools.backend.dto.RecipeCookingDTO
import com.martianlab.recipes.data.sources.backend.dto.RecipeDTO
import com.martianlab.recipes.data.sources.backend.dto.RecipeIngredientDTO
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
internal class RecipeSearchResponseBodyDTO(


    @SerialName("RecipeList")
    val recipeList: List<RecipeDTO>? = null,


    @SerialName("RecipeCookingList")
    val recipeCookingList: List<RecipeCookingDTO>?= null,

    @SerialName("Category")
    val categoryList: List<CategoryDTO>?= null,

    @SerialName("Total")
    val total: Int,

    @SerialName("ErrorList")
    val errors: Array<UtkerrorDTO>?= null,

    @SerialName("RecipeIngredientList")
    val ingredientList: List<RecipeIngredientDTO>?= null
)