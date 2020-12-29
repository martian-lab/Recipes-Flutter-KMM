package com.martianlab.recipes.data.sources.backend

import io.ktor.client.HttpClient

expect class HttpClientFactory {
    fun createHttpClient(): HttpClient

}