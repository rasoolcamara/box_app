// ignore_for_file: prefer_const_constructors

import 'package:box_app/app_properties.dart';
import 'package:box_app/screens/auth/login.dart';
import 'package:box_app/screens/home/home.dart';
// import 'package:box_app/screens/auth/welcome_back_page.dart';
import 'package:flutter/material.dart';
import 'package:box_app/Screens/intro_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> opacity;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var status = prefs.getBool('isLoggedIn') ?? false;
    print('Le status');
    print(status);

    if (status) {
      activeToken = prefs.getString('activeToken');
      userId = prefs.getInt('userId');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HomeScreen(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 100,
      decoration: BoxDecoration(
        color: blue,
        image: DecorationImage(
          image: AssetImage('assets/images/icon.png'),
          // fit: BoxFit.fill,
        ),
        // // color: Colors.transparent.withOpacity(0.1),
      ),
      // child: SvgPicture.asset(
      //   'assets/images/icon.svg',
      //   // fit: BoxFit.cover,
      // ),
    );
  }
}
