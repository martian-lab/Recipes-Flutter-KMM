import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_flutter/models/category.dart';
import 'package:recipes_flutter/models/recipe.dart';

import 'recipe_card.dart';
import 'title_with_more_button.dart';

class RecipeCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Category>(builder: (context, Category category, child) {
      print('category updated, cat=' + category.title + " " + category.recipes.length.toString());
      return Column(
        children: <Widget>[
          TitleWithCustomUnderline(
            title: category.title,
          ),
          //category.recipes.isEmpty ? CircularProgressIndicator() :
          Container(
              height: 300,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: min(category.recipes.length, 15),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    return Provider<Recipe>.value(
                        value: category.recipes[i], child: RecipeCard());
                  }))
        ],
      );
    });
  }
}

