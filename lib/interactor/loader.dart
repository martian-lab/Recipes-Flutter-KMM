import 'dart:convert';
import 'package:recipes_flutter/models/category.dart';
import 'package:recipes_flutter/models/recipe.dart';
import 'platform/platform.dart';

class Loader {

  static Future<List<Category>> loadCategories() {
    Future<String> res = platform.invokeMethod("getCategories", null);

    Future<List<Category>> catList = res.then((String value) async {
      var parsedJson = json.decode(value) as List;
      var categories = parsedJson.map((model) => Category.fromJson(model))
          .toList();
      categories.forEach((category) {
        loadRecipes(category).then((recipes) => category.setRecipes(recipes));
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