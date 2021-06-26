import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpaway/View/Components/touchBar.dart';
import 'package:helpaway/const.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

double _originLatitude = 38.43828143103933;
double _originLongitude = 27.14136619613852;

class _LocationState extends State<Location> {
  final PanelController _pc = PanelController();
  bool detailed = false;
  GoogleMapController _controller;
  static final CameraPosition _initalCameraPosition = CameraPosition(
    target: LatLng(_originLatitude, _originLongitude),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SlidingUpPanel(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      controller: _pc,
      panel: getPanel(),
      minHeight: 150,
      maxHeight: 250,
      body: googleMap(),
    ));
  }

  Widget googleMap() {
    return GoogleMap(
      myLocationButtonEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: _initalCameraPosition,
      tiltGesturesEnabled: true,
      compassEnabled: true,
      scrollGesturesEnabled: true,
      zoomGesturesEnabled: true,
      markers: _cretaeMarker(),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
    );
  }

  getPanel() {
    if (detailed) {
      return detailedPlace();
    } else {
      return placeCard();
    }
  }

  Set<Marker> _cretaeMarker() {
    return <Marker>[
      Marker(
          infoWindow: InfoWindow(title: "Destination"),
          markerId: MarkerId("asdasd"),
          position: _initalCameraPosition.target,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)),
      Marker(
          infoWindow: InfoWindow(title: "Konak Pier"),
          markerId: MarkerId("asdasdd"),
          position: LatLng(38.392300, 27.047840),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)),
      Marker(
          infoWindow: InfoWindow(title: "You"),
          markerId: MarkerId("asdsasdd"),
          position: LatLng(38.422733197746986, 27.129490953156576),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)),
    ].toSet();
  }

  placeCard() {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        GestureDetector(
            onTap: () {
              if (!detailed) {
                setState(() {
                  detailed = true;
                });
              } else {
                setState(() {
                  detailed = false;
                });
              }
              setState(() {
                if (detailed) {
                  _pc.open();
                } else {
                  _pc.close();
                }
              });
            },
            child: TouchBar()),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "William Restaurant",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: darkBrown1),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Mr. Wiston Smith 27 \nVictoria Street, Hounslow, Middle ",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontSize: 17),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 70,
                width: 120,
                child: Image.asset(
                  "assets/images/restaurant.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  detailedPlace() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        placeCard(),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Available until:",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: darkBrown1),
              ),
              SizedBox(
                height: 5,
              ),
              Text("06:00 - 20:00",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Text(
                "Contact:",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: darkBrown1),
              ),
              SizedBox(
                height: 5,
              ),
              Text("+447911123456",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }
}
