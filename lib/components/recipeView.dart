import 'package:flutter/material.dart';
import 'package:recipes_flutter/recipe.dart';

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
