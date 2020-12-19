import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_flutter/models/category.dart';
import 'package:recipes_flutter/screens/recipeDetails.dart';

import 'package:recipes_flutter/constants.dart';
import 'package:recipes_flutter/models/recipe.dart';

// class RecipeCategory2 extends StatelessWidget {
//   final Category category;
//
//   const RecipeCategory2({Key key, this.category}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 300,
//         child: ListView.builder(
//             shrinkWrap: true,
//             physics: ClampingScrollPhysics(),
//             itemCount: min(category.recipes.length, 15),
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, i) {
//               return RecipeCard(
//                   recipe: category.recipes[i],
//                   press: () => Navigator.pushNamed(context, RecipeDetails.routeName,
//                       arguments: category.recipes[i])
//               );
//             }));
//   }
// }
//
// class RecipeCategory extends StatelessWidget {
//   final Category category;
//
//   const RecipeCategory({Key key, this.category}) : super(key: key);
//
//   List<Widget> _createChildren(BuildContext context) {
//     return new List<Widget>.generate(min(category.recipes.length, 15), (int i) {
//       return RecipeCard(
//           recipe: category.recipes[i],
//           press: () => Navigator.pushNamed(context, RecipeDetails.routeName,
//               arguments: category.recipes[i]));
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(children: _createChildren(context)),
//     );
//     // else
//     //   return Text("");
//   }
// }

class RecipeCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Recipe recipe = Provider.of<Recipe>(context, listen: false);
    Function onPress = () => Navigator.pushNamed(context, RecipeDetails.routeName, arguments: recipe);

    return Container(
        margin: EdgeInsets.only(
            left: kDefaultPadding,
            top: kDefaultPadding / 2,
            bottom: kDefaultPadding * 2.5),
        width: size.width * 0.4,
        child: GestureDetector(
            onTap: onPress,
            child: Column(
              children: [
                //Image.network(recipe.imageURL, fit: BoxFit.cover,),
                CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(),
                  imageUrl: recipe.imageURL,
                ),
                Container(
                    padding: EdgeInsets.all(kDefaultPadding / 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: kPrimaryColor.withOpacity(0.23))
                        ]),
                    child: Row(
                      children: <Widget>[
                        RichText(
                            overflow: TextOverflow.fade,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "${recipe.title}\n".toUpperCase(),
                                  style: Theme.of(context).textTheme.button),
                              // TextSpan(
                              //     text: "${recipe.complexity}".toUpperCase(),
                              //     style: TextStyle(
                              //         color: kPrimaryColor.withOpacity(0.5)
                              //     )
                              // )
                            ])),
                        Spacer(),
                        Text("${recipe.personCount}",
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: kPrimaryColor))
                      ],
                    ))
              ],
            )));
  }
}
