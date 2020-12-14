package com.martianlab.data.sources.db_new.entities

import commartianlabrecipesshareddbcache.*


internal data class RecipeWithDependenciesEntity(

    val recipeEntity: RecipeEntity,

    val tags : Set<RecipeTagEntity>,

    val stages : List<RecipeStageEntity>,

    val ingredients : List<RecipeIngredientEntity>,

    val comments: List<RecipeCommentEntity>

)