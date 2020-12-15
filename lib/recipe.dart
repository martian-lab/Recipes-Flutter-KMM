// import 'package:json_annotation/json_annotation.dart';
// part 'category.g.dart';


//@JsonSerializable()
class Recipe{

  int id;
  String title;
  String imageURL;
  String text;
  int complexity;
  int personCount;
  double rating;
  int ratingVotes;
  List<RecipeTag> tags;
  List<RecipeStage> stages;
  List<RecipeIngredient> ingredients;
  List<RecipeComment> comments;

  Recipe(this.id, this.title, this.imageURL);

  Recipe.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    imageURL = data['imageURL'].toString().isNotEmpty
        ? data['imageURL']
        : null ?? null;
    text = data['text'];
    complexity = data['complexity'];
    personCount = data['personCount'];
    rating = data['rating'];
    ratingVotes = data['ratingVotes'];
    
    tags = (data['tags'] as List).map((model) => RecipeTag.fromJson(model)).toList();
    stages = (data['stages'] as List).map((model) => RecipeStage.fromJson(model)).toList();
    ingredients = (data['ingredients'] as List).map((model) => RecipeIngredient.fromJson(model)).toList();
    comments = (data['comments'] as List).map((model) => RecipeComment.fromJson(model)).toList();
  }

  @override
  String toString() {
    return 'Recipe{id: $id, title: $title, imageUrl: $imageURL, text: $text, complexity: $complexity, personCount: $personCount, rating: $rating, ratingVotes: $ratingVotes, tags: $tags, stages: $stages, ingredients: $ingredients, comments: $comments}';
  }

// factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  //
  // /// `toJson` is the convention for a class to declare support for serialization
  // /// to JSON. The implementation simply calls the private, generated
  // /// helper method `_$UserToJson`.
  // Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

class RecipeStage{
   int id;
   int recipeId;
   String imageURL;
   String text;
   int step;

   RecipeStage.fromJson(Map<String, dynamic> data) {
     id = data['id'];
     recipeId = data['recipeId'];
     imageURL = data['imageURL'].toString().isNotEmpty
         ? data['imageURL']
         : null ?? null;
     text = data['text'];
     step = data['step'];
   }

   RecipeStage(this.id, this.recipeId, this.imageURL, this.text, this.step);

   @override
  String toString() {
    return 'RecipeStage{id: $id, recipeId: $recipeId, imageURL: $imageURL, text: $text, step: $step}';
  }
}

class RecipeIngredient{
  int id;
  int recipeId;
  String title;
  String quantity;
  String measureUnit;
  int position;

  RecipeIngredient.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    recipeId = data['recipeId'];
    quantity = data['quantity'];
    measureUnit = data['measureUnit'];
    position = data['position'];
  }

  RecipeIngredient(this.id, this.recipeId, this.title, this.quantity,
      this.measureUnit, this.position);

  @override
  String toString() {
    return 'RecipeIngredient{id: $id, recipeId: $recipeId, title: $title, quantity: $quantity, measureUnit: $measureUnit, position: $position}';
  }
}

class RecipeComment{
  int id;
  int recipeId;
  int authorId;
  String authorName;
  String date;
  String text;
  int parentCommentId;
  List<String> photoURLs;

  RecipeComment.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    recipeId = data['recipeId'];
    authorId = data['authorId'];
    authorName = data['authorName'];
    date = data['date'];
    parentCommentId = data['parentCommentId'];
    recipeId = data['recipeId'];

    photoURLs = null ;//data['photoURLs'].toString().isNotEmpty ?  (data['photoURLs'] as List).map((e) => e.toString()) : null ?? null;
  }

  RecipeComment(this.id, this.recipeId, this.authorId, this.authorName,
      this.date, this.text, this.parentCommentId, this.photoURLs);

  @override
  String toString() {
    return 'RecipeComment{id: $id, recipeId: $recipeId, authorId: $authorId, authorName: $authorName, date: $date, text: $text, parentCommentId: $parentCommentId, photoURLs: $photoURLs}';
  }
}

class RecipeTag{
  int id;
  int recipeId;
  String title;

  RecipeTag.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    recipeId = data['recipeId'];
  }

  RecipeTag(this.id, this.recipeId, this.title);

  @override
  String toString() {
    return 'RecipeTag{id: $id, recipeId: $recipeId, title: $title}';
  }
}