import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:recipes_flutter/models/recipe.dart';

class RecipeDetails extends StatelessWidget {
  static const routeName = '/recipe';

  final List<ListItem> items = [];

  @override
  Widget build(BuildContext context) {
    final Recipe recipe = ModalRoute.of(context).settings.arguments;

    items.clear();
    items.add(RecipeImageViewItem(recipe.imageURL));
    items.add(RecipeComplexityViewItem(recipe.getComplexityName()));
    items.add(RecipePersonCountViewItem(recipe.personCount));
    items.add(RecipeSectionSubTitleViewItem("Ингредиенты"));
    for(final ingredient in recipe.ingredients) {
      items.add(RecipeIngredientViewItem(ingredient));
    }
    items.add(RecipeSectionSubTitleViewItem("Порядок приготовления"));
    for(final stage in recipe.stages) {
      items.add(RecipeStageViewItem(stage));
    }


    return Scaffold(
        appBar: AppBar(
          title: Text(recipe.title),
          elevation: 0,
          leading: IconButton(
              icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
              color: Colors.white,
              onPressed: () => Navigator.pop(context)
          ),
        ),
        body: Center(
            child: Container(
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Container(
                          child: item.buildSection(context)
                      );
                    }
                )
            )
        )
    );
  }
}


abstract class ListItem {
  Widget buildSection(BuildContext context);
}



class RecipeImageViewItem implements ListItem {
  final String url;

  RecipeImageViewItem(this.url);

  Widget buildSection(BuildContext context) =>
      SizedBox(
          child: AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: url,
              )
          )
      );
}

class RecipeComplexityViewItem implements ListItem {

  final String complexityName;

  RecipeComplexityViewItem(this.complexityName);

  Widget buildSection(BuildContext context) =>
      Text(
          "Сложность: ${complexityName}",
          style: Theme.of(context).textTheme.button
      );
}

class RecipeSectionSubTitleViewItem implements ListItem {

  final String title;

  RecipeSectionSubTitleViewItem(this.title);

  Widget buildSection(BuildContext context) =>
      Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          )
      );
}


class RecipePersonCountViewItem implements ListItem {

  final int personCount;

  RecipePersonCountViewItem(this.personCount);

  Widget buildSection(BuildContext context) =>
      Text("Персон: ${personCount}",
          style: Theme.of(context).textTheme.bodyText1
      );
}

class RecipeIngredientViewItem implements ListItem {

  final RecipeIngredient ingredient;

  RecipeIngredientViewItem(this.ingredient);

  Widget buildSection(BuildContext context) =>
      Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          Row(
            children: [
              Text(ingredient.position.toString()),
              Text(ingredient.title),
              Spacer(),
              Text(ingredient.quantity),
              Text(ingredient.measureUnit)
            ],
          )
      );
}

class RecipeStageViewItem implements ListItem {

  final RecipeStage stage;

  RecipeStageViewItem(this.stage);

  Widget buildSection(BuildContext context) =>
      Text("${stage.step.toString()} ${stage.text} ");
}