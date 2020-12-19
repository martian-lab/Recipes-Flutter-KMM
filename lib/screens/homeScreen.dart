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

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           leading: IconButton(
//             icon: SvgPicture.asset("assets/icons/menu.svg"),
//             onPressed: () {},
//           ),
//         ),
//         body: Consumer<Loader>(builder: (context, counter, child) {
//           return Body(counter);
//         }));
//   }
// }
//
//
// class _MainAppBar extends StatelessWidget {
//
//   const _MainAppBar({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       leading: IconButton(
//         icon: SvgPicture.asset("assets/icons/menu.svg"),
//         onPressed: () {},
//       ),
//     );
//   }
// }

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
                value:  categories[i],
                child: Column(
                  children: <Widget>[
                    TitleWithCustomUnderline(
                      title: categories[i].title,
                    ),
                    Consumer<Category>(builder: (context, Category category, child){
                      print('category updated, cat=' + category.title + " " + category.recipes.length.toString());
                      return Container(
                          height: 300,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: min(category.recipes.length, 15),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return Provider<Recipe>.value(
                                    value: category.recipes[i], child: RecipeCard());
                              }));
                    })
                  ],
                ));
          });
    });
  }
}

class RecipeCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Recipe> recipes = Provider.of<List<Recipe>>(context, listen: false);

    return Container(
        height: 300,
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: min(recipes.length, 15),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return Provider<Recipe>(
                  create: (_) => recipes[i], child: RecipeCard());
            }));
  }
}
