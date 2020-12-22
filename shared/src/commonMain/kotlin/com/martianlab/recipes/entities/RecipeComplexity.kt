package com.martianlab.recipes.entities

enum class RecipeComplexity(val title: String, val num : Int ){
    LOW("низкая",1 ), MEDIUM("средняя",2 ), HIGH("высокая", 3);

    companion object{
        fun getByNum(num : Int ) = values().find { it.num == num  }?.title ?: "хз"
    }
}