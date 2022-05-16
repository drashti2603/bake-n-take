//@dart=2.9
import '/Ui/home.dart';
import '/View_Model/search_view_model.dart';
import '/autoComplete.dart';
import 'directions_model.dart';
import '/base/base_view.dart';
import '/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'directions_repository.dart';
import 'directions_model.dart';

class Search extends StatefulWidget {
  LatLng orderdest;
  Search({this.orderdest});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //final Geolocator geolocator = Geolocator().forceAndroidLocationManager;
  GoogleMapController mapController;

  Marker destination;
  Marker origin;
  Directions info;
  // ignore: unused_field
  Location _location = Location();
  LatLng _initialcameraposition = LatLng(45.521563, -122.677433);
  Location location = new Location();

  void _onMapCreated(GoogleMapController controlr) async {
    GoogleMapController _controller = controlr;
    LocationData currentloc = await location.getLocation();
    setState(() {
      origin = Marker(
          markerId: MarkerId('origin'),
          position: LatLng(currentloc.latitude, currentloc.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          ));
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: origin.position, zoom: 15),
        ),
      );
    });

    if (widget.orderdest != null) addDestination(widget.orderdest);
  }

  void addDestination(LatLng pos) async {
    setState(() {
      if (pos != null) {
        info = null;

        destination = Marker(
            markerId: const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            position: pos,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ));
      }
    });

    final directions = await DirectionsRepository()
        .getDirections(origin: origin.position, destination: pos);
    setState(() => info = directions);
  }

  final LatLng _center = const LatLng(45.521563, -122.677433);

  static final CameraPosition _myLocation =
      CameraPosition(target: LatLng(0.0, 0.0));

  @override
  Widget build(BuildContext context) {
    return BaseView<SearchViewModel>(
        onModelReady: (model) {},
        builder: (context, model, build) {
          return WillPopScope(
            child: SafeArea(
              child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    centerTitle: true,
                    // bottom: PreferredSize(
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(left: 28.0),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: <Widget>[
                    //           Text(
                    //             "Find My location",
                    //             style: TextStyle(
                    //                 fontSize: 28,
                    //                 fontWeight: FontWeight.bold),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     preferredSize: Size.fromHeight(30.0)),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                    ),
                    title: Text('Location',
                        style: TextStyle(
                            fontSize: 20.0, color: Color(0xFF545D68))),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.notifications_none,
                            color: Color(0xFFC88D67)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  body: Stack(
                    children: <Widget>[
                      Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                              child: Container(
                            width: double.infinity,
                            child: //MyMap()

                                Stack(alignment: Alignment.center, children: [
                              GoogleMap(
                                polylines: {
                                  if (info != null)
                                    Polyline(
                                      polylineId:
                                          const PolylineId('overview_polyline'),
                                      color: Colors.red,
                                      width: 5,
                                      points: info.polylinePoints
                                          .map((e) =>
                                              LatLng(e.latitude, e.longitude))
                                          .toList(),
                                    ),
                                },
                                onMapCreated: _onMapCreated,
                                markers: {
                                  if (destination != null) destination,
                                  // if (origin != null) origin
                                },
                                onLongPress: (pos) => destination == null
                                    ? addDestination(pos)
                                    : setState(() {
                                        destination = null;
                                        info = null;
                                      }),
                                myLocationButtonEnabled: true,
                                myLocationEnabled: true,
                                initialCameraPosition: CameraPosition(
                                  target: _initialcameraposition,
                                  zoom: 11.0,
                                ),
                              ),
                              if (info != null)
                                Positioned(
                                  top: 20.0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6.0,
                                      horizontal: 12.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.yellowAccent,
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0, 2),
                                          blurRadius: 6.0,
                                        )
                                      ],
                                    ),
                                    child: Text(
                                      '${info.totalDistance}, ${info.totalDuration}',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                            ]),
                          )),
                        ],
                      )

//                             child: GoogleMap(
//                               initialCameraPosition: _myLocation,
//                               mapType: MapType.normal, myLocationEnabled: true,
// // onMapCreated: (GoogleMapController controller) {
// ////// _controller.complete(controller);
// ////// },
//                               onMapCreated: model.onMapCreated,
//                               markers: model.markers,
//                               compassEnabled: false,
//                               myLocationButtonEnabled: false,
//                             ),
                          ),
                      SizedBox(
                        height: 10,
                      ),
//                           Padding(
//                             padding: const EdgeInsets.all(6.0),
//                             child: PredictionListAutoComplete(
//                               data: model.predictionL,
//                               textField: TextField(
// // textAlign: TextAlign.center,
//                                   cursorColor: Colors.black,
//                                   onSubmitted: model.onSubmitForm,
// //onChanged: mapModel.onPickupTextFieldChanged, not using it for now
//                                   controller: model.formFieldController,
//                                   decoration: InputDecoration(
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Colors.black),
//                                       borderRadius: BorderRadius.all(
//                                         Radius.circular(12),
//                                       ),
//                                     ),
//                                     hintStyle: TextStyle(
//                                       color: Colors.grey[500],
//                                     ),
//                                     hintText: "Your location",
//                                     suffixIcon: Icon(
//                                       Icons.search,
//                                       color: Colors.grey[500],
//                                     ),
//                                     border: new OutlineInputBorder(
//                                         borderSide:
//                                             new BorderSide(color: Colors.black),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(12))),
//                                   ),
//                                   keyboardType: TextInputType.text,
//                                   textInputAction: TextInputAction.go),
//                               itemTap: model.onPredictionItemClick,
//                             ),
//                           ),
                    ],
                  )),
            ),
            onWillPop: () async {
              print('WILLPOPCSOPE');
              model.clearAllModels();
              return true;
            },
          );
        });
  }
}
