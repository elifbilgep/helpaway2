import 'package:flutter/material.dart';

class BigHeader1 extends StatelessWidget {
  final text;

  const BigHeader1({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 160),
      child: Container(
        height: 120,
        width: 250,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}

class BigHeader2 extends StatelessWidget {
  final text;
  final EdgeInsets padding;

  const BigHeader2({Key key, this.text, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        height: 120,
        width: 220,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
