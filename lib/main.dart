// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'category.dart';
import 'recipe.dart';
import 'interactor/platform/platform.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    // Provide the model to all widgets within the app. We're using
    // ChangeNotifierProvider because that's a simple way to rebuild
    // widgets when a model changes. We could also just use
    // Provider, but then we would have to listen to Counter ourselves.
    //
    // Read Provider's docs to learn about all the available providers.
    ChangeNotifierProvider(
      // Initialize the model in the builder. That way, Provider
      // can own Counter's lifecycle, making sure to call `dispose`
      // when not needed anymore.
      create: (context) => Counter(),
      child: MyApp(),
    ),
  );
}

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.
///
class Counter with ChangeNotifier {
  int value = 0;
  static const platform = const MethodChannel(METHOD_CHANNEL_NAME);
  List<Category> categories = [];

  Counter() {
    // platform.setMethodCallHandler((call) async {
    //   print('updateCategoriesList, method=' + call.method + ' args=' + call.arguments);
    //
    //   var parsedJson = json.decode(call.arguments) as List;
    //   categories = parsedJson.map((model) => Category.fromJson(model)).toList();
    //
    //   print('decoded=' + categories.toString());
    //   notifyListeners();
    //   //}
    // });
    platform.setMethodCallHandler((call) async {
      switch( call.method ){

        case 'updateCategoryList':
          var parsedJson = json.decode(call.arguments) as List;
          categories = parsedJson.map((model) => Category.fromJson(model)).toList();
          notifyListeners();
          break;

        case 'updateRecipeList':
          print('recipes');
          var catId = call.arguments['categoryId'] as int;
          print('recipes catid=' + catId.toString());
          var parsedJson = json.decode(call.arguments['recipeList']) as List;
          //print('recipes parsedJson=' + parsedJson.toString());
          //var recipes = parsedJson.map((model) => Recipe.fromJson(model)).toList();
          //print('recipes=' + recipes.toString());
          notifyListeners();
          break;
      }
    });
    // platform.setMethodCallHandler((call) async {
    //   switch( call.method ){
    //
    //     // case 'updateCategoryList':
    //     //   var parsedJson = json.decode(call.arguments) as List;
    //     //   categories = parsedJson.map((model) => Category.fromJson(model)).toList();
    //     //   break;
    //
    //     case 'updateRecipeList':
    //       print('recipes');
    //       var catId = call.arguments['categoryId'] as int;
    //       print('recipes catid=' + catId.toString());
    //       var parsedJson = json.decode(call.arguments['recipeList']) as List;
    //       //print('recipes parsedJson=' + parsedJson.toString());
    //       //var recipes = parsedJson.map((model) => Recipe.fromJson(model)).toList();
    //       //print('recipes=' + recipes.toString());
    //       notifyListeners();
    //       break;
    //   }
    // });
    //platform.invokeMethod("method", null);
  }

  void enlarge(){
     Future<String> res = platform.invokeMethod("method", null);

     res.then((String value) async{
       var parsedJson = json.decode(value) as List;
       var categories2 = parsedJson.map((model) => Category.fromJson(model)).toList();
       print('decoded2=' + categories2.toString());
       categories.addAll(categories2);
       notifyListeners();
     });
  }

  void increment() {
    value++;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
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
      body: Consumer<Counter>(
        builder: (context, counter, child) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: counter.categories.length,
          itemBuilder: (context, i) {
            if( i >= counter.categories.length-3 )
              counter.enlarge();
            return ListTile(
              contentPadding: const EdgeInsets.all(16),
                title: Text(
              counter.categories[i].title,
              style: TextStyle(fontSize:24),
            ));
          },
        ),
      ),
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
          var counter = context.read<Counter>();
          counter.increment();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
