import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:helpaway/Services/Auth.dart';
import 'package:helpaway/View/Components/button.dart';
import 'package:helpaway/const.dart';

class OwnerPage extends StatefulWidget {
  @override
  _OwnerPageState createState() => _OwnerPageState();
}

class _OwnerPageState extends State<OwnerPage> {
  int choosenIndex;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
        body: TabBarView(
          children: [
            myItems(),
            addItem(context),
          ],
        ),
      ),
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
                  "William Restaurant",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  "Mr. Wiston Smith 27 Victoria Street, Hounslow,Middle ",
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(fontSize: 12),
                )
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
            Padding(
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
                      height: 100,
                      width: 130,
                      child: Image.asset(
                        "assets/images/main_course.png",
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
                          "Chicken Breast",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "William Restaurant",
                          style: Theme.of(context).textTheme.headline6.copyWith(
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
                              "22.00",
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
            )
          ],
        )
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
                      TextFormField(
                        cursorColor: darkBrown1,
                        decoration: InputDecoration(
                            hintText: "Food name",
                            hintStyle: Theme.of(context).textTheme.headline3,
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
                              cursorColor: darkBrown1,
                              decoration: InputDecoration(),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Button1(
              color: darkBrown1,
              text: "Add Item",
            )
          ],
        ),
      ],
    );
  }
}
