import 'package:flutter/material.dart';
import 'package:helpaway/const.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: darkBrown1),
          child: Center(
            child: Text(
              "Logo",
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
