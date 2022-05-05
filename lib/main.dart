// ignore_for_file: prefer_const_constructors

import 'package:box_app/app_properties.dart';
import 'package:box_app/screens/splash_page.dart';
import 'package:box_app/services/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  return runApp(App());
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized ` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  final LocationService locationService = LocationService();

  @override
  void initState() {
    super.initState();

    locationService.determinePosition().then((value) {
      print("hereeee");
      print(value.latitude);
      print(value.longitude);

      getAddressFromLatLong(value.latitude, value.longitude);
    });
  }

  Future<void> getAddressFromLatLong(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    // print("placemarks");
    // print(placemarks);

    Placemark place = placemarks[0];
    currentCoutry = place.isoCountryCode;
    // print("L'adresse");

    // print(place);
    // print(place.isoCountryCode);

    // print("POSITIONN ACTUEL");

    // print(currentCoutry);
  }

  final spinkit = SpinKitRing(
    color: orange.withOpacity(0.5),
    lineWidth: 10.0,
    size: 100.0,
  );
  // final spinkit = SpinKitCircle(
  //   itemBuilder: (BuildContext context, int index) {
  //     return DecoratedBox(
  //       decoration: BoxDecoration(color: index.isEven ? blue : Colors.black),
  //     );
  //   },
  // );

  @override
  Widget build(BuildContext context) {
    print("Nous sommes ici avec succés");
    return MaterialApp(
      title: 'Box App',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
