package com.martianlab.recipes.domain.api


internal interface PreferencesApi {

    val isFirstAppLaunch: Boolean

    val isApplicationStarted: Boolean

    val deviceId: String

    var numberOfAppLaunches: Int

    var appTheme: String

}