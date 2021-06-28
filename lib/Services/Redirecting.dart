import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/owner.dart';
import '../View/Pages/owner_page.dart';
import '../View/Pages/s%C4%B1gnIn.dart';
import '../const.dart';
import 'Auth.dart';


class Redirecting extends StatefulWidget {
  @override
  _RedirectingState createState() => _RedirectingState();
}

class _RedirectingState extends State<Redirecting> {
  String _activeUserId;

  @override
  Widget build(BuildContext context) {
    _activeUserId = Provider.of<Authorization>(context).activeUserId;
    final _authService = Provider.of<Authorization>(context, listen: false);
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
            backgroundColor: white1,
          )));
        } else if (snapshot.hasData) {
          Owner activeUser = snapshot.data;
          _authService.activeUserId = activeUser.id;
          return OwnerPage();
        } else {
          return SignIn();
        }
      },
      stream: _authService.stateFollower,
    );
  }
}
