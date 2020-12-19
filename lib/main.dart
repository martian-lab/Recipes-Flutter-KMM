import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_flutter/common/theme.dart';
import 'package:recipes_flutter/main_.dart';
import 'package:recipes_flutter/models/category.dart';
import 'package:recipes_flutter/models/recipe.dart';

import 'models/loader.dart';
import 'screens/homeScreen.dart';
import 'screens/recipeDetails.dart';

void main() {
  runApp(RecipesApp());
}

class RecipesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<Category>>.value(
      value: RecipesViewModel().categories,
      initialData: List.empty(),
      child: MaterialApp(
        title: 'Recipes Demo',
        theme: appTheme(context),
        initialRoute: '/',
        routes: {
          '/': (context) => MainPage(),
          '/recipe': (context) => RecipeDetails()
        },
      ),
    );
  }
}
