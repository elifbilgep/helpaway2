import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import '../../Models/owner.dart';
import '../../Models/restaurantItem.dart';
import '../../Services/Auth.dart';
import '../../Services/Firestore_service.dart';
import '../../const.dart';
import '../Components/button.dart';

class OwnerPage extends StatefulWidget {
  @override
  _OwnerPageState createState() => _OwnerPageState();
}

class _OwnerPageState extends State<OwnerPage> {
  List<RestaurantItem> foods;
  String _currentAddress;
  Owner owner;
  var activeUserId;
  int choosenIndex;
  String takenFoodCategory;
  String takenFoodName;
  String takenAvailable;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    activeUserId = Provider.of<Authorization>(context).activeUserId;
    return DefaultTabController(
        length: 2,
        child: FutureBuilder(
          future: FirestoreService().bringUser(activeUserId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            owner = snapshot.data;
            _getAddressFromLatLng();
            return buildScaffold(context);
          },
        ));
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: buildDrawer(context),
        appBar: AppBar(
          backgroundColor: darkBrown1,
          bottom: TabBar(
            labelStyle: Theme.of(context).textTheme.headline3,
            indicatorColor: white1,
            tabs: [
              Tab(
                text: "My Items",
              ),
              Tab(
                text: "Add Item",
              )
            ],
          ),
        ),
        body: buildTabBarView(context));
  }

  TabBarView buildTabBarView(BuildContext context) {
    return TabBarView(
      children: [
        myItems(),
        addItem(context),
      ],
    );
  }

  buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  owner.placeName,
                  style: Theme.of(context).textTheme.headline2,
                ),
                if (_currentAddress != null) Text(_currentAddress)
              ],
            ),
            decoration: BoxDecoration(color: white1),
          ),
          ListTile(
            title: Text("Edit profile"),
            leading: Icon(Icons.edit),
          ),
          ListTile(
            onTap: () {
              Authorization().signOut();
            },
            title: Text("Log out"),
            leading: Icon(Icons.logout),
          )
        ],
      ),
    );
  }

  myItems() {
    return FutureBuilder(
      future: FirestoreService().bringOwnerFoods(activeUserId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        foods = snapshot.data;
        return buildStack();
      },
    );
  }

  Stack buildStack() {
    return Stack(
      children: [
        Container(
            height: double.infinity,
            width: double.infinity,
            child: Opacity(
                opacity: 0.6,
                child: Image.asset(
                  "assets/images/owner_bg.jpg",
                  fit: BoxFit.cover,
                ))),
        ListView.builder(
            itemCount: foods.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Container(
                  height: 150,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade700,
                            blurRadius: 5,
                            spreadRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 90,
                        width: 130,
                        child: Image.asset(
                          "assets/images/${foods[index].foodCategory}.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(),
                          Text(
                            foods[index].foodName,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            owner.placeName,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "Avaiable until: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.w700),
                              ),
                              Text(
                                foods[index].availableUntil,
                                style: Theme.of(context).textTheme.headline3,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }

  addItem(context) {
    return Stack(
      children: [
        Container(
            height: double.infinity,
            width: double.infinity,
            child: Opacity(
                opacity: 0.6,
                child: Image.asset(
                  "assets/images/owner_bg.jpg",
                  fit: BoxFit.cover,
                ))),
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 350,
                width: 370,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade700,
                        spreadRadius: 3,
                        blurRadius: 5)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/icon/fork.png",
                            height: 25,
                            width: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Categories",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: darkBrown1),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 120,
                        width: 350,
                        child: GridView.builder(
                            clipBehavior: Clip.none,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 140,
                                    childAspectRatio: 3.4,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemCount: 4,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    choosenIndex = index;
                                  });
                                  takenFoodCategory =
                                      foodCategory[choosenIndex];
                                },
                                child: Container(
                                  child: Center(
                                      child: Text(
                                    foodCategory[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(fontWeight: FontWeight.bold),
                                  )),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 2),
                                            color: choosenIndex == index
                                                ? Colors.grey.shade700
                                                : Colors.grey.shade400,
                                            blurRadius: 5,
                                            spreadRadius: 2)
                                      ]),
                                ),
                              );
                            }),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              onSaved: (newValue) => takenFoodName = newValue,
                              cursorColor: darkBrown1,
                              decoration: InputDecoration(
                                  hintText: "Food name",
                                  hintStyle:
                                      Theme.of(context).textTheme.headline3,
                                  prefixIcon: Icon(
                                    Icons.text_fields,
                                    color: darkBrown1,
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  EvaIcons.clock,
                                  color: darkBrown1,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Available until:    ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .copyWith(fontWeight: FontWeight.w900)),
                                Container(
                                  width: 100,
                                  height: 30,
                                  child: TextFormField(
                                    onSaved: (newValue) =>
                                        takenAvailable = newValue,
                                    cursorColor: darkBrown1,
                                    decoration: InputDecoration(),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                createItem();
              },
              child: Button1(
                color: darkBrown1,
                text: "Add Item",
              ),
            )
          ],
        ),
      ],
    );
  }

  void createItem() async {
    var activeUserId =
        Provider.of<Authorization>(context, listen: false).activeUserId;
    _formKey.currentState.save();
    await FirestoreService().createFoodItem(
      availableUntil: takenAvailable,
      foodCategory: takenFoodCategory,
      foodName: takenFoodName,
      publisherId: activeUserId,
      longitude: owner.longitude,
      latitude: owner.latitude,
      restaurantName: owner.placeName,
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Item added succesfully.")));
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(owner.latitude, owner.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}
