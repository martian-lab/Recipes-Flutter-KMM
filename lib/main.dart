// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_flutter_app/home_screen.dart';
import 'package:provider/provider.dart';
import 'category.dart';
import 'recipe.dart';
import 'interactor/platform/platform.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app/constants.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Loader(),
      child: MyApp(),
    ),
  );
}

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Loader] does
/// _not_ depend on Provider.
///
class Loader with ChangeNotifier {
  int value = 0;
  static const platform = const MethodChannel(METHOD_CHANNEL_NAME);
  List<Category> categories = [];
  //List<Recipe> recipes = [];

  Loader() {
    platform.setMethodCallHandler((call) async {
      if( call.method == 'updateCategoryList'){
        loadCategories();
      }
    });
    loadCategories();
  }

  void loadCategories() {
    Future<String> res = platform.invokeMethod("getCategories", null);

    res.then((String value) async {
      var parsedJson = json.decode(value) as List;
      categories = parsedJson.map((model) => Category.fromJson(model)).toList();
      print('categories num=' + categories.length.toString());
      categories.forEach((category) {
        loadRecipes(category).then((value) {
          category.recipes = value;
          if( categories.every((element) => element.recipes.length > 0 ))
            notifyListeners();
        });
      });
      print('loaded category[0] recipes length=' +
          categories[0].recipes.length.toString());
      notifyListeners();
    });
  }

  Future<List<Recipe>> loadRecipes(Category category) {
    print('load category id=' + category.id.toString());
    Future<String> res =
        platform.invokeMethod("getRecipesByCategory", category.id);

    var result = res.then((String value) async {
      var parsedJson = json.decode(value) as List;
      return parsedJson.map((model) => Recipe.fromJson(model)).toList();
    });
    return result;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodplex Flutter Demo',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kBackgroundColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: HomeScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: Consumer<Loader>(builder: (context, counter, child) {

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: counter.categories.length,
          itemBuilder: (context, i) {
            // if( i >= counter.categories.length-3 )
            //   counter.enlarge();
            return ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  counter.categories[i].title +
                      '  ' +
                      counter.categories[i].recipes.length.toString(),
                  style: TextStyle(fontSize: 24),
                ));
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // You can access your providers anywhere you have access
          // to the context. One way is to use Provider<Counter>.of(context).
          //
          // The provider package also defines extension methods on context
          // itself. You can call context.watch<Counter>() in a build method
          // of any widget to access the current state of Counter, and to ask
          // Flutter to rebuild your widget anytime Counter changes.
          //
          // You can't use context.watch() outside build methods, because that
          // often leads to subtle bugs. Instead, you should use
          // context.read<Counter>(), which gets the current state
          // but doesn't ask Flutter for future rebuilds.
          //
          // Since we're in a callback that will be called whenever the user
          // taps the FloatingActionButton, we are not in the build method here.
          // We should use context.read().
          var counter = context.read<Loader>();
          //counter.increment();
          print('loaded category[0] recipes length=' +
              counter.categories[0].recipes.length.toString());
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
