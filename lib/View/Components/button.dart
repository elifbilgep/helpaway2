import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  final Color color;
  final String text;

  const Button1({Key key, this.color, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 50,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(50)),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class Button2 extends StatelessWidget {
  final Color color;
  final String text;

  const Button2({Key key, this.color, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 50,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(50)),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
