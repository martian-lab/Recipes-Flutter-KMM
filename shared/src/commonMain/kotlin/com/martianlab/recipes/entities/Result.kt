package com.martianlab.recipes.entities

sealed class Result<out T> {
    data class Success<T>(val data: T?) : Result<T>()
    data class Failure(val statusCode: Int?) : Result<Nothing>()
    object NetworkError : Result<Nothing>()
}