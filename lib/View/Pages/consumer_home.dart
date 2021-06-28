import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/restaurantItem.dart';
import '../../Services/Auth.dart';
import '../../Services/Firestore_service.dart';
import '../../const.dart';
import 'location_food.dart';

class ConsumerHome extends StatelessWidget {
  var activeUserId;
  List<RestaurantItem> foods;
  @override
  Widget build(BuildContext context) {
    activeUserId =
        Provider.of<Authorization>(context, listen: false).activeUserId;
    return Scaffold(
      backgroundColor: white2,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            buildSearchBar(context),
            SizedBox(
              height: 20,
            ),
            buildCategories(context),
            SizedBox(
              height: 20,
            ),
            buildList(context),
          ],
        ),
      ),
    );
  }

  Center buildSearchBar(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20),
        child: Container(
          height: 50,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    offset: Offset.zero,
                    spreadRadius: 5)
              ]),
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(
                Icons.search,
                size: 35,
                color: Colors.grey.shade400,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Search",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.grey.shade500),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildCategories(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Container(
        height: 300,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categories",
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 250,
              child: ListView.builder(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemCount: mainCategories.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 5,
                                        spreadRadius: 2)
                                  ]),
                              height: 250,
                              width: 250,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  "assets/images/${mainCategories[index]}",
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                        Positioned(
                          top: 220,
                          left: 20,
                          child: Text(
                            mainCategoryNames[index],
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset.zero,
                                  blurRadius: 10.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  buildList(BuildContext context) {
    return FutureBuilder(
      future: FirestoreService().bringAllFoods(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        foods = snapshot.data;
        return Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Restaurants",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 453,
              child: ListView.builder(
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 20, right: 20),
                      child: Container(
                        height: 160,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
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
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  foods[index].foodName,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  foods[index].restaurantName,
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
                                      "22.00",
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      return Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LocationPage()));
                                    },
                                    child: Container(
                                        height: 30,
                                        width: 110,
                                        child: Center(
                                          child: Text(
                                            "location",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 17),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: darkBrown1)))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}
