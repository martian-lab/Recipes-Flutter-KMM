import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:recipes_flutter/models/category.dart';
import 'package:recipes_flutter/models/recipe.dart';

class Loader {

  static const String METHOD_CHANNEL_NAME = 'recipes/platform';
  static const platform = const MethodChannel(METHOD_CHANNEL_NAME);

  Loader() {
    platform.setMethodCallHandler((call) async {
      if( call.method == 'updateCategoryList'){
        loadCategories();
      }
    });
  }

  static Future<List<Category>> loadCategories() {
    Future<String> res = platform.invokeMethod("getCategories", null);

    Future<List<Category>> catList = res.then((String value) async {
      var parsedJson = json.decode(value) as List;
      var categories = parsedJson.map((model) => Category.fromJson(model))
          .toList();
      categories.forEach((category) {
        loadRecipes(category).then((value) => category.recipes = value);
      });
      return categories;
    });
    return catList;
  }


  static Future<List<Recipe>> loadRecipes(Category category) {
    print('load category id=' + category.id.toString());
    Future<String> res = platform.invokeMethod(
        "getRecipesByCategory", category.id);

    var result = res.then((String value) async {
      var parsedJson = json.decode(value) as List;
      return parsedJson.map((model) => Recipe.fromJson(model)).toList();
    });
    return result;
  }

}