import 'package:flutter/foundation.dart';
import 'package:recipes_flutter/interactor/loader.dart';
import 'package:recipes_flutter/interactor/platform/platform.dart';
import 'package:recipes_flutter/models/category.dart' as Models;



class RecipesViewModel extends ChangeNotifier {
  List<Models.Category> categories = List.empty();

  RecipesViewModel(){
    loadCategories();
    platform.setMethodCallHandler((call) async {
      if( call.method == 'updateCategoryList'){
        print('cats update');
        loadCategories();
      }
      if( call.method == 'updateCategory'){
        int id = call.arguments as int;
        print('cat update' + id.toString() );
        loadCategoryRecipes(id);
      }
    });
  }

  void loadCategoryRecipes(int id) async{
    Models.Category category = categories.firstWhere((Models.Category element) => element.id == id );
    if( category != null ) {
      var recipes = await Loader.loadRecipes(category);
      category.setRecipes(recipes);
    }
  }

  void loadCategories() async{
    categories = await Loader.loadCategories();
    notifyListeners();
  }
}



