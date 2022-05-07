import 'dart:async';
import 'dart:convert';
import 'package:slbfe_website/global.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:http/http.dart' as http;

class Location extends StatefulWidget {

  int nic;

  Location(this.nic);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {

  Completer<GoogleMapController> _controller = Completer();

  late CameraPosition userLoc;

  Future<void> goToUserLoc() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(userLoc));
  }

  Set<Marker> markers = {};

  Future<LatLng> getLocation() async {
    List coordinates = [];
    double lat = 0.0;
    double lng = 0.0;
    String url = "${Urls.apiUrl}/api/JsUser/location?NIC=${widget.nic}";
    final response = await http.get(Uri.parse(url));
    var resJson = json.decode(response.body);
    if (response.statusCode == 200) {
      var a = resJson as List;
      coordinates = a.toList();
      lat = coordinates[0]['Latitude'] as double;
      lng = coordinates[0]['Longitude'] as double;

      return LatLng(lat, lng);
    }
    else {
      print(response.reasonPhrase);
      return LatLng(lat, lng);
    }
  }

  void addMarker(double? lat, double? lng){
    setState(() {
      markers.add(
          Marker(
            markerId: const MarkerId('user'),
            infoWindow:
            const InfoWindow(title: 'User Location'),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(lat!, lng!),
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //getLocation();
    return FutureBuilder<LatLng>(
      future: getLocation(),
      builder: (context, snapshot) {
        if(snapshot.hasData){

          LatLng? loc1 = snapshot.data;

          return Container(
            child: GoogleMap(
              markers: markers,
              initialCameraPosition: CameraPosition(target: LatLng(loc1!.latitude, loc1.longitude), zoom: 5),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                addMarker(loc1.latitude, loc1.longitude);
                userLoc = CameraPosition(
                  target: LatLng(loc1.latitude, loc1.longitude),
                  zoom: 5,
                );
                goToUserLoc();
              },
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      }
    );
  }
}
