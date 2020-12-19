import 'package:flutter/material.dart';
import 'package:recipes_flutter/common/constants.dart';

ThemeData appTheme(BuildContext context) => ThemeData(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kBackgroundColor,
    textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
    visualDensity: VisualDensity.adaptivePlatformDensity
);
