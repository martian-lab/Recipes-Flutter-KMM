    package com.martianlab.data.sources.backend

import com.martianlab.recipes.domain.api.BackendApi
import com.martianlab.recipes.entities.Category
import com.martianlab.recipes.entities.Recipe
import com.martianlab.recipes.entities.Result
import com.martianlab.recipes.data.sources.backend.dto.response.RecipeSearchResponseBodyDTO
import com.martianlab.recipes.data.sources.backend.dto.response.UtkoresponseDTO
import com.martianlab.recipes.tools.backend.mapper.toCategory
import com.martianlab.recipes.tools.backend.mapper.toCategoryList
import com.martianlab.recipes.tools.backend.mapper.toRecipeList
import io.ktor.client.*
import io.ktor.client.features.json.*
import io.ktor.client.features.json.serializer.*
import io.ktor.client.request.*
import io.ktor.http.*
import io.ktor.util.network.*
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json


internal class BackendKtorImpl() : BackendApi{

    private val URL = "http://www.utkonos.ru/api/rest/"
    private val nonStrictJson = Json { isLenient = true; ignoreUnknownKeys = true }

    val client: HttpClient = HttpClient{
        install(JsonFeature) {
            serializer = KotlinxSerializer(nonStrictJson)
        }
    }

    private val apiHelper = ApiHelper(client, URL)


    override suspend fun recipeSearch(
        categoryId: Long,
        recipeId: Long,
        count: Int,
        offset: Int
    ): Result<List<Recipe>> {
        val query = "{\"Head\":{\"Method\":\"RecipeSearch\",\"RequestId\":\"2f34f026c8c16373395610b5d36e92c7\",\"MarketingPartnerKey\":\"123123123\",\"DeviceId\":\"1572680090\",\"Created\":\"Fri, 15 Nov 2019 09:37:08 GMT\",\"Client\":\"\",\"AdvertisingId\":\"\",\"AppsFlyerId\":\"\"},\"Body\":{\"Count\":\"$count\",\"Id\":\"\",\"CategoryId\":\"$categoryId\",\"Offset\":\"$offset\",\"Return\":{\"Cooking\":\"1\",\"Ingredient\":\"1\",\"Goods\":\"1\",\"BestRecipes\":\"\",\"Comments\":\"1\",\"Seo\":\"\"}}}"
        return apiHelper.recipeSearch(
            request= query,
            methodName = "RecipeSearch",
            androidId = "000"
        )//.also { println("KTOR:::, result=" + it) }
         .map {
            it.body.toRecipeList()
        }.also { println("KTOR:::, result=" + it) }
    }

    override suspend fun getCategories(): Result<List<Category>> {
        val query = "{\"Head\":{\"Method\":\"RecipeSearch\",\"RequestId\":\"2f34f026c8c16373395610b5d36e92c7\",\"MarketingPartnerKey\":\"123123123\",\"DeviceId\":\"1572680090\",\"Created\":\"Fri, 15 Nov 2019 09:37:08 GMT\",\"Client\":\"\",\"AdvertisingId\":\"\",\"AppsFlyerId\":\"\"},\"Body\":{\"Count\":\"611\",\"Id\":\"\",\"CategoryId\":\"\",\"Offset\":\"\",\"Return\":{\"Cooking\":\"1\",\"Ingredient\":\"1\",\"Goods\":\"1\",\"BestRecipes\":\"\",\"Comments\":\"1\",\"Seo\":\"\"}}}"
        return apiHelper.recipeSearch(
            request= query,
            methodName = "RecipeSearch",
            androidId = "000"
        )//.also { println("KTOR:::, result=" + it) }
        .map{
            it.body.toCategoryList()
        }.also { println("KTOR:::, result=" + it) }
    }

    override suspend fun getCategory(categoryId: Long): Result<Category?> {
        val query = "{\"Head\":{\"Method\":\"RecipeSearch\",\"RequestId\":\"8b81a580dab497ee4b3d0acc50fa68a0\",\"MarketingPartnerKey\":\"123123123\",\"DeviceId\":\"1572680090\",\"Created\":\"Sat, 16 Nov 2019 08:13:24 GMT\",\"Client\":\"\",\"AdvertisingId\":\"\",\"AppsFlyerId\":\"\"},\"Body\":{\"Count\":\"\",\"Id\":\"\",\"CategoryId\":\"$categoryId\",\"Offset\":\"\",\"Return\":{\"Cooking\":\"\",\"Ingredient\":\"\",\"Goods\":\"\",\"BestRecipes\":\"\",\"Comments\":\"\",\"Seo\":\"\"}}}"
        return apiHelper.recipeSearch(
            request= query,
            methodName = "RecipeSearch",
            androidId = "000"
        )//.also { println("KTOR:::, result=" + it) }
        .map{
            it.body.toCategory()
        }.also { println("KTOR:::, result=" + it) }
    }

}

internal class ApiHelper(val client: HttpClient, val URL : String ){

    private val nonStrictJson = Json { isLenient = true; ignoreUnknownKeys = true }

    internal suspend fun recipeSearch(
        request : String,
        methodName : String,
        androidId : String
    ): Result<UtkoresponseDTO<RecipeSearchResponseBodyDTO>>{
        try {
            val res = client.request<String>(URL) {
                parameter("request", request)
                method = HttpMethod.Get
                accept(ContentType.Application.Json)
                headers {
                    append("Content-Type", "application/json")
                    append("x-mob-sgm", androidId)
                    append("x-mob-method", methodName)
                }
            }.let {
                nonStrictJson.decodeFromString<UtkoresponseDTO<RecipeSearchResponseBodyDTO>>(
                    it
                )
            }

            return Result.Success(res)
        }catch (e : UnresolvedAddressException){
            return Result.NetworkError
        }catch ( e : Exception ){
            println("KTOR:::, exc=" + e )
            return Result.Failure(null)
        }

    }
}

private fun <From, To>  Result<From>.map(entityMapper: (From) -> To): Result<To> =
    when (this) {
        is Result.Success<From> -> Result.Success<To>(data?.let(entityMapper) )
        is Result.Failure -> Result.Failure(statusCode)
        is Result.NetworkError -> Result.NetworkError
    }