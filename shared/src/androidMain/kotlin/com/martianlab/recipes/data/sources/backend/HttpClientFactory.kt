package com.martianlab.recipes.data.sources.backend

import io.ktor.client.HttpClient
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import kotlinx.serialization.json.Json

actual class HttpClientFactory  {

    private val nonStrictJson = Json { isLenient = true; ignoreUnknownKeys = true }

    actual fun createHttpClient(): HttpClient{
        return HttpClient{
            install(JsonFeature) {
                serializer = KotlinxSerializer(nonStrictJson)
            }
        }
    }
}