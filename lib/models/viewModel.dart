import 'package:flutter/foundation.dart';
import 'package:recipes_flutter/interactor/loader.dart';
import 'package:recipes_flutter/interactor/platform/platform.dart';



class RecipesViewModel extends ChangeNotifier {
  var categories = Loader.loadCategories();

  RecipesViewModel(){
    platform.setMethodCallHandler((call) async {
      if( call.method == 'updateCategoryList'){
        categories = Loader.loadCategories();
      }
    });
  }

}



