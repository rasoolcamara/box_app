// ignore_for_file: prefer_const_constructors

import 'package:box_app/app_properties.dart';
import 'package:box_app/screens/auth/login.dart';
import 'package:box_app/screens/home/home.dart';
// import 'package:box_app/screens/auth/welcome_back_page.dart';
import 'package:flutter/material.dart';
import 'package:box_app/Screens/intro_page.dart';
import 'package:flutter_svg/svg.dart';

class SuccessSplashScreen extends StatefulWidget {
  const SuccessSplashScreen({
    Key key,
  }) : super(key: key);

  @override
  _SuccessSplashScreenState createState() => _SuccessSplashScreenState();
}

class _SuccessSplashScreenState extends State<SuccessSplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> opacity;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 4000), vsync: this);
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

  void navigationPage() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/success.png'),
                    // fit: BoxFit.fill,
                  ),
                  // // color: Colors.transparent.withOpacity(0.1),
                ),
                // child: SvgPicture.asset(
                //   'assets/images/icon.svg',
                //   // fit: BoxFit.cover,
                // ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Félicitations !",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Votre Box à été configurée avec succès!",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }
}
