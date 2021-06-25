import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpaway/const.dart';

import 'View/Pages/SıgnIn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projem',
      theme: ThemeData(
        textTheme: TextTheme(
            headline1: GoogleFonts.josefinSans(
              //slogan
              textStyle: TextStyle(
                  color: white2, fontSize: 40, fontWeight: FontWeight.w900),
            ),
            headline2: GoogleFonts.josefinSans(
              //welcome
              textStyle: TextStyle(
                  color: darkBrown1, fontSize: 40, fontWeight: FontWeight.w900),
            ),
            headline3: GoogleFonts.josefinSans(
              //textFormField/Categories/card header
              textStyle: TextStyle(
                  color: darkbrown3, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            headline4: GoogleFonts.josefinSans(
              //profile headlines
              textStyle: TextStyle(
                  color: darkBrown2, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            bodyText1: GoogleFonts.josefinSans(
              //button dark
              textStyle: TextStyle(
                  color: darkBrown1,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            bodyText2: GoogleFonts.josefinSans(
              //button white , cards
              textStyle: TextStyle(
                  color: white2, fontSize: 18, fontWeight: FontWeight.normal),
            )),
        primaryColor: darkBrown1,
      ),
      home: SignIn(),
    );
  }
}
