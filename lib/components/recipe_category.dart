import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/category.dart';

import 'package:my_flutter_app/constants.dart';
import 'package:my_flutter_app/recipe.dart';

class RecipeCategory2 extends StatelessWidget {

  final Category category;

  const RecipeCategory2({
    Key key,
    this.category
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if( category.recipes.length > 0 )
      return ListView.builder(
          itemCount: category.recipes.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return RecipeCard(
                recipe : category.recipes[i],
                press: null,
            );
          }
      );
    else
      return Text("");
    // return SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //
    //   // child: Row(
    //   //   children: <Widget>[
    //   //     RecipeCard(
    //   //         image: "https://gcdn.utkonos.ru/resample/recipe-mobile/images/recipe/recipe_4867_A49C50A52A7F5BE9C88FA5169486A3E6-_A7A1461.jpg",
    //   //         title: "Куриный бульон",
    //   //         difficult: "средняя",
    //   //         countOfPerson: 4,
    //   //         press: (){}
    //   //     ),
    //   //     RecipeCard(
    //   //         image: "https://gcdn.utkonos.ru/resample/recipe-mobile/images/recipe/20200709161452-final.jpg",
    //   //         title: "Свекольник",
    //   //         difficult: "низкая",
    //   //         countOfPerson: 4,
    //   //         press: (){}
    //   //     ),
    //   //     RecipeCard(
    //   //         image: "https://gcdn.utkonos.ru/resample/recipe-mobile/images/recipe/20200430160301-final.jpg",
    //   //         title: "Крем-суп с гречкой и печенью",
    //   //         difficult: "средняя",
    //   //         countOfPerson: 4,
    //   //         press: (){}
    //   //     ),
    //   //   ],
    //   // ),
    // );
  }
}

class RecipeCategory extends StatelessWidget {

  final Category category;

  const RecipeCategory({
    Key key,
    this.category
  }) : super(key: key);

  List<Widget> _createChildren(){
    return new List<Widget>.generate(min(category.recipes.length,15), (int i) {
      return RecipeCard(recipe: category.recipes[i], press: () {});
    });
  }

  @override
  Widget build(BuildContext context) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,

        child: Row(
          children: _createChildren()
        ),
      );
    // else
    //   return Text("");
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    Key key,
    this.recipe,
    this.press
  }) : super(key: key);

  final Recipe recipe;
  final Function press;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.only(
            left: kDefaultPadding,
            top: kDefaultPadding / 2,
            bottom: kDefaultPadding * 2.5
        ),
        width: size.width * 0.4,
        child: Column(
          children: [
            //Image.network(recipe.imageURL, fit: BoxFit.cover,),
            CachedNetworkImage(
              placeholder: (context, url) => CircularProgressIndicator(),
              imageUrl: recipe.imageURL,
            ),
            GestureDetector(
                onTap: press,
                child: Container(
                    padding: EdgeInsets.all(kDefaultPadding/2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0,10),
                              blurRadius: 50,
                              color: kPrimaryColor.withOpacity(0.23)
                          )
                        ]
                    ),
                    child: Row(
                      children: <Widget>[
                        RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                      text:"${recipe.title}\n".toUpperCase(),
                                      style: Theme.of(context).textTheme.button
                                  ),
                                  TextSpan(
                                      text: "${recipe.complexity}".toUpperCase(),
                                      style: TextStyle(
                                          color: kPrimaryColor.withOpacity(0.5)
                                      )
                                  )
                                ]
                            )
                        ),
                        Spacer(),
                        Text(
                            "${recipe.personCount}",
                            style: Theme.of(context).textTheme.button.copyWith(color: kPrimaryColor)

                        )
                      ],
                    )
                )
            )
          ],
        )
    );
  }
}