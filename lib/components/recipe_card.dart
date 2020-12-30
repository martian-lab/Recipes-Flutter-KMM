import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_flutter/screens/recipeDetails.dart';

import 'package:recipes_flutter/common/constants.dart';
import 'package:recipes_flutter/models/recipe.dart';

class RecipeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Recipe recipe = Provider.of<Recipe>(context, listen: false);
    Function onPress = () => Navigator.pushNamed(
        context, RecipeDetails.routeName,
        arguments: recipe);
    Size size = MediaQuery.of(context).size;

    return Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(right: 12, bottom: 20, top: 8),
        child: GestureDetector(
            onTap: onPress,
            child: Container(
                width: size.height * 0.2,
                child: Stack(children: [
                  CachedNetworkImage(
                    height: size.height * 0.2,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    imageUrl: recipe.imageURL,
                  ),
                  Positioned(
                      bottom: 18,
                      width: size.height * 0.2,
                      height: size.height * 0.065,
                      // child: Padding(
                      //   padding: const EdgeInsets.only(
                      //       left: 4, right: 4, top: 8, bottom: 2),
                        child: RichText(
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          text: TextSpan(
                              text: "${recipe.title}\n".toUpperCase(),
                              style: Theme.of(context).textTheme.button),
                        ),
                      ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text("${recipe.getComplexityName()}".toUpperCase(),
                          style:
                              TextStyle(color: kPrimaryColor.withOpacity(0.5))))
                ]))));
  }
}

class RecipeCard2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Recipe recipe = Provider.of<Recipe>(context, listen: false);
    Function onPress = () => Navigator.pushNamed(
        context, RecipeDetails.routeName,
        arguments: recipe);

    return Container(
        margin: EdgeInsets.only(
            left: kDefaultPadding,
            top: kDefaultPadding / 2,
            bottom: kDefaultPadding * 2.5),
        //width: size.width * 0.4,
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
                        Flexible(
                            flex: 20,
                            fit: FlexFit.tight,
                            child: Container(
                                child: RichText(
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              "${recipe.title}\n".toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .button),
                                      TextSpan(
                                          text: "${recipe.getComplexityName()}"
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: kPrimaryColor
                                                  .withOpacity(0.5)))
                                    ])))),
                        Text("${recipe.personCount}",
                            textAlign: TextAlign.end,
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
