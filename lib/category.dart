// import 'package:json_annotation/json_annotation.dart';
// part 'category.g.dart';


//@JsonSerializable()
import 'package:recipes_flutter/recipe.dart';

class Category{

  int id;
  String title;
  String imageUrl;
  int sort;
  int total;
  List<Recipe> recipes = [];

  Category(this.id, this.title, this.imageUrl, this.sort, this.total);

  Category.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    imageUrl = data['imageUrl'].toString().isNotEmpty
        ? data['imageUrl']
        : null ?? null;
    sort = data['sort'];
    total = data['total'];
  }

  @override
  String toString() {
    return 'Category{id: $id, title: $title, imageUrl: $imageUrl, sort: $sort, total: $total}';
  }

// factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  //
  // /// `toJson` is the convention for a class to declare support for serialization
  // /// to JSON. The implementation simply calls the private, generated
  // /// helper method `_$UserToJson`.
  // Map<String, dynamic> toJson() => _$CategoryToJson(this);
}