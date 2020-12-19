import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:recipes_flutter/components/recipe_category.dart';
import 'package:recipes_flutter/components/title_with_more_button.dart';
import 'package:recipes_flutter/models/category.dart';
import 'package:recipes_flutter/models/recipe.dart';
import 'package:recipes_flutter/screens/recipeDetails.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset("assets/icons/menu.svg"),
            onPressed: () {},
          ),
        ),
        body: Body());
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<List<Category>>(
        builder: (context, List<Category> categories, child) {
      return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: categories.length,
          itemBuilder: (context, i) {
            return ChangeNotifierProvider<Category>.value(
                value: categories[i],
                child: RecipeCategory()
             );
          });
    });
  }
}
