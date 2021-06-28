import 'package:flutter/material.dart';
import '../../const.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: darkBrown1),
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }
}
