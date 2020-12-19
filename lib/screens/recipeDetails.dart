import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_flutter/models/recipe.dart';

class RecipeDetails extends StatelessWidget {
  static const routeName = '/recipe';

  @override
  Widget build(BuildContext context) {
    final Recipe recipe = ModalRoute.of(context).settings.arguments;

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
