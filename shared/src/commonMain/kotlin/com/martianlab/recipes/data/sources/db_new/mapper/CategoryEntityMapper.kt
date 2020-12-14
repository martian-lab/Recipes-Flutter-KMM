package com.martianlab.recipes.data.sources.db_new.mapper

import com.martianlab.recipes.entities.Category
import commartianlabrecipesshareddbcache.CategoryEntity


internal object CategoryEntityMapper {
    fun map2Model( entity: CategoryEntity) : Category =
        Category(
            id = entity.id,
            title = entity.title,
            imageUrl = entity.imageUrl,
            sort = entity.sort,
            total = entity.total
        )

    fun map2Entity( model: Category) : CategoryEntity =
        CategoryEntity(
            id = model.id,
            title = model.title,
            imageUrl = model.imageUrl,
            sort = model.sort,
            total = model.total
        )

}


fun CategoryEntity.toModel() =
    CategoryEntityMapper.map2Model(this)

fun Category.toEntity() =
    CategoryEntityMapper.map2Entity(this)