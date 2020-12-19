

import 'package:flutter/cupertino.dart';
import 'package:recipes_flutter/interactor/platform/platform.dart';
import 'package:recipes_flutter/models/category.dart';

class RecipesViewModel extends ChangeNotifier {
  Future<List<Category>> categories = Loader.loadCategories();


}



