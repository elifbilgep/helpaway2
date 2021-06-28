import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../Models/owner.dart';
import '../../Services/Auth.dart';
import '../../Services/Firestore_service.dart';
import '../../const.dart';
import '../Components/bigHeader.dart';
import '../Components/button.dart';
import '../Components/logo.dart';
import '../Components/touchBar.dart';
import 'consumer_home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  File _imageFile;
  String imgUrl;

  final picker = ImagePicker();

  Position _currentPosition;

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  String takenPlaceName;
  String takenEmail;
  String takenPassword;
  String takenCategory;
  double takenLatidute;
  double takenLongitude;
// *****************************

  String takenEmail2;
  String takenPassword2;

  PanelController _pc = new PanelController();
  String dropdownValue = 'Restaurant';
  bool isOwner = false;
  bool isOwnerAndSignUp = false;
  bool isConsumer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SlidingUpPanel(
      controller: _pc,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      maxHeight: 520,
      minHeight: 30,
      panel: getWidget(),
      body: _body(),
    ));
  }

  Widget getWidget() {
    if (isOwner == true & !isOwnerAndSignUp) {
      return buildSignIn();
    } else if (isOwner == false) {
      return Column(
        children: [
          SizedBox(
            height: 5,
          ),
          TouchBar()
        ],
      );
    }
    if (isOwner == true & isOwnerAndSignUp) {
      return buildSignUp();
    }
  }

  Container buildSignUp() {
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            GestureDetector(
                onTap: () {
                  if (_pc.isPanelOpen) {
                    _pc.close();
                  }
                },
                child: TouchBar()),
            Row(
              children: [
                BigHeader2(
                  padding: EdgeInsets.only(top: 20, left: 10),
                  text: "Create an\nAccount",
                ),
              ],
            ),
            Container(
              height: 300,
              width: 300,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (newValue) => takenPlaceName = newValue,
                      decoration: InputDecoration(
                          hintText: "place name",
                          hintStyle:
                              Theme.of(context).textTheme.bodyText1.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          prefixIcon: Icon(
                            Icons.text_fields,
                            color: darkBrown1,
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onSaved: (newValue) => takenEmail = newValue,
                      decoration: InputDecoration(
                          hintText: "email",
                          hintStyle:
                              Theme.of(context).textTheme.bodyText1.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          prefixIcon: Icon(
                            Icons.mail,
                            color: darkBrown1,
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onSaved: (newValue) => takenPassword = newValue,
                      decoration: InputDecoration(
                          hintText: "password",
                          hintStyle:
                              Theme.of(context).textTheme.bodyText1.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: darkBrown1,
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Choose your category:",
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(color: darkBrown1, fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        buildDropdownButton(),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        signUp();
                      },
                      child: Button1(
                        text: "Sign up",
                        color: darkBrown1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward_sharp),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: darkbrown3),
      underline: Container(
        height: 2,
        color: darkBrown1,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
        takenCategory = newValue;
      },
      items: <String>['Restaurant', 'Market', 'Care House', 'Eating House']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Column buildSignIn() {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () async {
            if (_pc.isPanelOpen) {
              _pc.close();
            }
          },
          child: TouchBar(),
        ),
        BigHeader2(
          text: "Welcome",
          padding: EdgeInsets.only(top: 20, right: 70),
        ),
        Container(
          height: 350,
          width: 300,
          child: Form(
            key: _formKey2,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (newValue) => takenEmail2 = newValue,
                  decoration: InputDecoration(
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink)),
                      hintText: "email",
                      hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      prefixIcon: Icon(
                        Icons.mail,
                        color: darkBrown1,
                      )),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  onSaved: (newValue) => takenPassword2 = newValue,
                  decoration: InputDecoration(
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink)),
                      hintText: "password",
                      hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: darkBrown1,
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Forgot password?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.w900, fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    return signInAcc();
                  },
                  child: Container(
                    width: 280,
                    height: 50,
                    decoration: BoxDecoration(
                        color: darkBrown1,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Text(
                        "Sign in",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "or",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isOwnerAndSignUp = true;
                        });
                      },
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isOwnerAndSignUp = true;
                            _getCurrentLocation();
                          });
                        },
                        child: Text(
                          "Sign up",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              fontWeight: FontWeight.w900, color: darkBrown1),
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        )
      ],
    );
  }

  Opacity _body() {
    return Opacity(
      opacity: 0.78,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(signInImg), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Logo(),
            BigHeader1(
              text: "Love grows when we share...",
            ),
            SizedBox(
              height: 50,
            ),
            Center(
                child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        isOwner = true;
                      });

                      return _pc.open();
                    },
                    child:
                        Button1(color: darkBrown1, text: "Owner of business"))),
            SizedBox(
              height: 15,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ConsumerHome()));
                },
                child: Button2(
                  color: white1,
                  text: "Consumer",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  void signUp() async {
    debugPrint("tıklandı");
    final _authService = Provider.of<Authorization>(context, listen: false);
    _formKey.currentState.save();
    if (_currentPosition != null) {
      takenLatidute = _currentPosition.latitude;
      takenLongitude = _currentPosition.longitude;
    }

    Owner owner =
        await _authService.createUserWithMail(takenEmail, takenPassword);
    if (owner != null) {
      await FirestoreService().createOwner(
        email: takenEmail,
        id: owner.id,
        latitude: takenLatidute,
        longitude: takenLongitude,
        placeCategory: takenCategory,
        placeName: takenPlaceName,
      );
    }
  }

  void signInAcc() async {
    debugPrint("TIKLANDI");
    final _authService = Provider.of<Authorization>(context, listen: false);
    _formKey2.currentState.save();
    try {
      await _authService.signInWithMail(takenEmail2, takenPassword2);
    } catch (error) {
      print("error" + error.toString());
    }
  }
}
