import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpaway/Services/Auth.dart';
import 'package:helpaway/Services/Redirecting.dart';
import 'package:helpaway/const.dart';
import 'package:provider/provider.dart';

import 'View/Pages/sıgnIn.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Authorization>(create: (_)=> Authorization(),
          child: MaterialApp(
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
              headline5: GoogleFonts.josefinSans(
                //profile headlines
                textStyle: TextStyle(
                    color: darkBrown2, fontSize: 23, fontWeight: FontWeight.w800),
              ),
              headline6: GoogleFonts.josefinSans(
                //profile headlines
                textStyle: TextStyle(
                    color: white1, fontSize: 20, fontWeight: FontWeight.w800),
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
        home: Redirecting(),
      ),
    );
  }
}
