package com.martianlab.recipes

import com.martianlab.data.repository.RecipesRepositoryImpl
import com.martianlab.data.sources.backend.BackendKtorImpl
import com.martianlab.data.sources.db_new.DbImpl
import com.martianlab.recipes.data.sources.backend.HttpClientFactory
import com.martianlab.recipes.data.sources.db_new.DatabaseDriverFactory
import com.martianlab.recipes.domain.RecipesInteractor
import com.martianlab.recipes.domain.RecipesInteractorImpl
import com.martianlab.recipes.domain.RecipesRepository
import com.martianlab.recipes.domain.api.BackendApi
import com.martianlab.recipes.domain.api.DbApi
import com.martianlab.recipes.domain.api.RoutingApi

class RecipesSDK(
    httpClientFactory: HttpClientFactory,
    driverFactory: DatabaseDriverFactory
) {

    private val db : DbApi = DbImpl(driverFactory)
    private val backend : BackendApi = BackendKtorImpl(httpClientFactory)
    private val recipesRepository : RecipesRepository = RecipesRepositoryImpl(db, backend)

    val interactor : RecipesInteractor = RecipesInteractorImpl(recipesRepository)

}