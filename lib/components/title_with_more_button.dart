import 'package:flutter/material.dart';

import 'package:my_flutter_app/constants.dart';

class TitleWithMoreButton extends StatelessWidget {
  const TitleWithMoreButton({
    Key key,
    this.title,
    this.press
  }) : super(key: key);

  final Function press;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Row(
            children: [
              TitleWithCustomUnderline(
                title: title,
              ),
              Spacer(),
              FlatButton(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: press,
                  child: Text("more", style: TextStyle(color: Colors.white),)
              )
            ]
        )
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key key,
    this.title
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(left:0, right:0, bottom:0,
            child: Container(
              height: 7,
              color: kPrimaryColor.withOpacity(0.2),
              margin: EdgeInsets.only(right: kDefaultPadding / 4),
            ),
          )
        ],
      ),
    );
  }
}