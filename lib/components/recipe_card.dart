import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_flutter/screens/recipeDetails.dart';

import 'package:recipes_flutter/common/constants.dart';
import 'package:recipes_flutter/models/recipe.dart';

class RecipeCard extends StatelessWidget {
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
                                    ])
     )
     )
    ),
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
