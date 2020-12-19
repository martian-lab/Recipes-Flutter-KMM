import 'package:flutter/material.dart';
import 'package:recipes_flutter/models/category.dart';
import 'package:recipes_flutter/constants.dart';
import '../main_.dart';
import 'header_with_searchbox.dart';
import 'recipe_category.dart';
import 'title_with_more_button.dart';


// class CategoryView extends StatelessWidget{
//   final Category category;
//
//   CategoryView(this.category);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             TitleWithCustomUnderline(
//               title: category.title,
//             ),
//             RecipeCategory2(category: category,)
//           ],
//         )
//     );
//   }
// }