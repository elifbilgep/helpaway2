import 'package:flutter/material.dart';

import '../../const.dart';

class UploadPic extends StatelessWidget {
  const UploadPic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: darkBrown1)),
      child: Center(
          child:
              Opacity(opacity: 0.7, child: Icon(Icons.camera_alt, size: 35))),
    );
  }
}
