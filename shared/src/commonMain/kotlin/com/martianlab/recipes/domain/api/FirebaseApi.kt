package com.martianlab.recipes.domain.api

import com.martianlab.recipes.entities.FirebaseEvent


internal interface FirebaseApi {

    fun logEvent(event: FirebaseEvent)
}