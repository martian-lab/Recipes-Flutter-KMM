package com.martianlab.data.sources.db_new.mapper

import com.martianlab.data.sources.db_new.entities.RecipeWithDependenciesEntity
import com.martianlab.recipes.entities.*
import commartianlabrecipesshareddbcache.*
import kotlinx.datetime.DateTimeUnit
import kotlinx.datetime.Instant


internal object RecipeEntityMapper {
    fun map2Model( entity: RecipeEntity) : Recipe =
        Recipe(
            id = entity.id,
            title = entity.title,
            text = entity.text,
            imageURL = entity.imageURL,
            complexity = entity.complexity,
            personCount = entity.personCount,
            rating = entity.rating,
            ratingVotes = entity.ratingVotes,
            ingredients = listOf(),
            tags = listOf(),
            comments = listOf(),//entity.comments,
            stages = listOf()
        )

    fun map2Entity( recipe: Recipe) : RecipeEntity =
        RecipeEntity(
            id = recipe.id,
            title = recipe.title,
            text = recipe.text,
            imageURL = recipe.imageURL,
            complexity = recipe.complexity,
            personCount = recipe.personCount,
            rating = recipe.rating,
            ratingVotes = recipe.ratingVotes
        )

    fun map2Model( entity: RecipeWithDependenciesEntity) : Recipe =
        Recipe(
            id = entity.recipeEntity.id,
            title = entity.recipeEntity.title,
            text = entity.recipeEntity.text,
            imageURL = entity.recipeEntity.imageURL,
            complexity = entity.recipeEntity.complexity,
            personCount = entity.recipeEntity.personCount,
            rating = entity.recipeEntity.rating,
            ratingVotes = entity.recipeEntity.ratingVotes,
            ingredients = entity.ingredients.map { it.toRecipeIngredient() },
            tags = entity.tags.map { it.toRecipeTag() },
            comments = entity.comments.map { it.toRecipeComment() },
            stages = entity.stages.map { it.toRecipeStage() }
        )//.also { println("RECIPES:::: entity=" + entity ) }

    fun map2EntityWithDependencies( entity: Recipe) : RecipeWithDependenciesEntity =
        RecipeWithDependenciesEntity(
            recipeEntity = entity.toEntity(),
            ingredients = entity.ingredients.map { it.toEntity() },
            tags = entity.tags.map { it.toEntity() }.toSet(),
            comments = entity.comments.map { it.toEntity() },
            stages = entity.stages.map { it.toEntity() }
        )

    fun map2Model( entity: RecipeStageEntity) : RecipeStage =
        RecipeStage(
            id = entity.id,
            text = entity.text,
            recipeId = entity.recipeId,
            imageURL = entity.imageURL,
            step = entity.step
        )

    fun map2Model( entity: RecipeIngredientEntity) : RecipeIngredient =
        RecipeIngredient(
            id = entity.id,
            recipeId = entity.recipeId,
            title = entity.title,
            quantity = entity.quantity,
            measureUnit = entity.measureUnit,
            position = entity.position
        )

    fun map2Model( entity: RecipeCommentEntity) : RecipeComment =
        RecipeComment(
            id = entity.id,
            recipeId = entity.recipeId,
            text = entity.text,
            authorId = entity.authorId,
            authorName = entity.authorName,
            date = entity.date,
            parentCommentId = entity.parentCommentId,
            photoURLs = entity.photoURLs
        )

    fun map2Model( entity: RecipeTagEntity) : RecipeTag =
        RecipeTag(
            id = entity.id,
            title = entity.title,
            recipeId = entity.recipeId
        )

    fun map2Entity( entity: RecipeStage) : RecipeStageEntity =
        RecipeStageEntity(
            id = entity.id,
            text = entity.text,
            recipeId = entity.recipeId,
            imageURL = entity.imageURL,
            step = entity.step
        )

    fun map2Entity( entity: RecipeIngredient) : RecipeIngredientEntity =
        RecipeIngredientEntity(
            id = entity.id,
            recipeId = entity.recipeId,
            title = entity.title,
            quantity = entity.quantity,
            measureUnit = entity.measureUnit,
            position = entity.position
        )

    fun map2Entity( entity: RecipeComment) : RecipeCommentEntity =
        RecipeCommentEntity(
            id = entity.id,
            recipeId = entity.recipeId,
            text = entity.text,
            authorId = entity.authorId,
            authorName = entity.authorName,
            date = entity.date,
            parentCommentId = entity.parentCommentId,
            photoURLs = entity.photoURLs
        )

    fun map2Entity( entity: RecipeTag) : RecipeTagEntity =
        RecipeTagEntity(
            id = entity.id,
            title = entity.title,
            recipeId = entity.recipeId
        )
}

internal fun RecipeIngredient.toEntity() =
    RecipeEntityMapper.map2Entity(this)

internal fun RecipeStage.toEntity() =
    RecipeEntityMapper.map2Entity(this)

internal fun RecipeComment.toEntity() =
    RecipeEntityMapper.map2Entity(this)

internal fun RecipeTag.toEntity() =
    RecipeEntityMapper.map2Entity(this)

internal fun RecipeTagEntity.toRecipeTag() =
    RecipeEntityMapper.map2Model(this)

internal fun RecipeCommentEntity.toRecipeComment() =
    RecipeEntityMapper.map2Model(this)

internal fun RecipeIngredientEntity.toRecipeIngredient() =
    RecipeEntityMapper.map2Model(this)

internal fun RecipeStageEntity.toRecipeStage() =
    RecipeEntityMapper.map2Model(this)

internal fun RecipeWithDependenciesEntity.toRecipe() =
    RecipeEntityMapper.map2Model(this)

internal fun RecipeEntity.toRecipe() =
    RecipeEntityMapper.map2Model(this)

internal fun Recipe.toEntity() =
    RecipeEntityMapper.map2Entity(this)

internal fun Recipe.toEntityWithDependencies() =
    RecipeEntityMapper.map2EntityWithDependencies(this)