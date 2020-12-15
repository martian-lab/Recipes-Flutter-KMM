import 'package:flutter/material.dart';
import 'package:my_flutter_app/category.dart';
import 'package:my_flutter_app/constants.dart';
import '../main.dart';
import 'header_with_searchbox.dart';
import 'recipe_category.dart';
import 'title_with_more_button.dart';

class Body extends StatelessWidget {

  final Loader loader;

  Body(this.loader);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: loader.categories.length,
        itemBuilder: (context, i) {
          return CategoryView(loader.categories[i]);
        }
    );

  }
}
class CategoryView extends StatelessWidget{
  final Category category;

  CategoryView(this.category);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TitleWithCustomUnderline(
              title: category.title,
            ),
            RecipeCategory(category: category,)
          ],
        )
    );
  }
}