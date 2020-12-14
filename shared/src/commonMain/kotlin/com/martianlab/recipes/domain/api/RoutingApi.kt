package com.martianlab.recipes.domain.api

import com.martianlab.recipes.entities.Destination

interface RoutingApi {

    fun goTo( destination : Destination )

    fun goBack()
}

