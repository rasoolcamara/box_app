// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:box_app/app_properties.dart';
import 'package:box_app/models/user.dart';
import 'package:box_app/screens/admin/admin.dart';
import 'package:box_app/screens/bottom_nav_bar.dart';
import 'package:box_app/screens/history/history.dart';
import 'package:box_app/screens/home/home_screen.dart';
import 'package:box_app/services/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  static final String path = "lib/src/pages/animations/anim4.dart";

  HomeScreen({
    Key key,
    // this.user,
  }) : super(key: key);

  // User user;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage;

  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final ApplicationService applicationServica = ApplicationService();

  final spinkit = SpinKitRing(
    color: orange.withOpacity(0.5),
    lineWidth: 10.0,
    size: 100.0,
  );

  @override
  void initState() {
    // Future<String> _token = _prefs.then((SharedPreferences prefs) {
    //   return prefs.getString("activeToken");
    // });

    _currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: applicationServica.getApplication(activeToken, userId),
        builder: (_, snapshot) {
          print("SnapSHOT");
          print(snapshot.data);
          if (snapshot.data != null) {
            return getPage(_currentPage);
          } else {
            return Center(
              child: spinkit,
            );
          }
        },
      ),
      bottomNavigationBar: AnimatedBottomNav(
        currentIndex: _currentPage,
        onChange: (index) {
          setState(
            () {
              _currentPage = index;
            },
          );
        },
      ),
    );
  }

  getPage(int page) {
    switch (page) {
      case 0:
        return Center(
          child: HomeScreenPage(),
        );
      case 1:
        return Center(
          child: HistoryPage(),
        );
      case 2:
        return Center(
          child: AdminPage(),
        );
    }
  }
}
