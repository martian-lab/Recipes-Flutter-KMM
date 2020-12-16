import 'package:flutter/material.dart';
import 'package:my_flutter_app/recipe.dart';

class RecipeView extends StatelessWidget {
  final Recipe recipe;

  RecipeView(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Center(
          child: Column(children: [
        Text("Сложность: ${recipe.getComplexityName()}",
            style: Theme.of(context).textTheme.button),
        Text("Персон: ${recipe.personCount}")
      ])),
    );
  }
}
