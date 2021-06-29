import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Components/touchBar.dart';
import '../../const.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

double _originLatitude = 37.421998333333335;
double _originLongitude = -122.084;

double _destLatitude = 37.40858141498359;
double _destLongitude = -122.07795124544703;

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    super.initState();
    setCustomMarker();
    _getPolyline();
  }

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  BitmapDescriptor customIcon;

  final PanelController _pc = PanelController();
  bool detailed = false;
  GoogleMapController _controller;
  CameraPosition _initalCameraPosition = CameraPosition(
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

  getPanel() {
    if (detailed) {
      return detailedPlace();
    } else {
      return placeCard();
    }
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
                  "Aykut Kokorec",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: darkBrown1),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Mountain View, 94043,\nUnited States ",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              width: 10,
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

  Widget googleMap() {
    return GoogleMap(
      markers: _cretaeMarker(),
      polylines: Set<Polyline>.of(polylines.values),
      myLocationButtonEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: _initalCameraPosition,
      tiltGesturesEnabled: true,
      compassEnabled: true,
      scrollGesturesEnabled: true,
      zoomGesturesEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
    );
  }

  Set<Marker> _cretaeMarker() {
    return <Marker>[
      Marker(
          infoWindow: InfoWindow(title: "You"),
          markerId: MarkerId("asdasd"),
          position: _initalCameraPosition.target,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
      Marker(
          infoWindow: InfoWindow(title: "Konak Pier"),
          markerId: MarkerId("asdasdd"),
          position: LatLng(37.40858141498359, -122.07795124544703),
          icon: customIcon),
    ].toSet();
  }

  void setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(50, 50)), "assets/images/location.png");
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAeZ57ZGRaPD-u6N9CtBeTkC1P_5iwYYqU",
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(37.40858141498359, -122.07795124544703),
      travelMode: TravelMode.walking,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }
}
