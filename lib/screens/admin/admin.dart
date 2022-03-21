// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:box_app/app_properties.dart';
import 'package:box_app/models/transaction.dart';
import 'package:box_app/models/wallet.dart';
import 'package:box_app/screens/admin/disburse.dart';
import 'package:box_app/screens/admin/disburse_connexion.dart';
import 'package:box_app/screens/auth/login.dart';
import 'package:box_app/screens/history/transaction.dart';
import 'package:box_app/screens/home/home.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // final UserService userService = UserService();

  String _countryCode = "+221";

  bool _loading = false;

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
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            "Administrateur",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: gray,
            ),
          ),
        ),
        elevation: 0.0,
      ),
      body: _loading
          ? spinkit
          : ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      // height: _height,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 90,
                            width: 350,
                            decoration: BoxDecoration(
                              // image: DecorationImage(
                              //   image: AssetImage('assets/images/home.png'),
                              //   fit: BoxFit.cover,
                              // ),
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            padding: const EdgeInsets.all(0.0),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 0.0),
                              child: ListTile(
                                leading: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                    color: blue,
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    activeApplication.user.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: gray,
                                    ),
                                  ),
                                ),
                                subtitle: Text(
                                  "Id marchand: " +
                                      activeApplication.accountNumber,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: gray,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Divider(
                            height: 0.5,
                            color: gray.withOpacity(0.5),
                          ),
                          // Retirer de l'argent
                          InkWell(
                            onTap: () {
                              print("Retrait");

                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      DisburseConnexionPage(),
                                  // transitionDuration:
                                  //     Duration(milliseconds: 300),
                                  // transitionsBuilder: (_,
                                  //     Animation<double> animation,
                                  //     __,
                                  //     Widget child) {
                                  //   return Opacity(
                                  //     opacity: animation.value,
                                  //     child: child,
                                  //   );
                                  // },
                                ),

                                // MaterialPageRoute(
                                //   builder: (_) => DisburseConnexionPage(),

                                // ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 40,
                                right: 5.0,
                                left: 10.0,
                              ),
                              child: ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: blue,
                                    size: 30,
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Retirer de l'argent",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: gray,
                                    ),
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: gray,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          // Contacter un de nos agents
                          InkWell(
                            onTap: () {
                              print("Contacter un de nos agents");
                              launch("tel://+221776738631");
                              // _callSAV();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 16,
                                right: 5.0,
                                left: 10.0,
                              ),
                              child: ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.phone,
                                    color: blue,
                                    size: 25,
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Contacter un de nos agents",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: gray,
                                    ),
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: gray,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          // Se déconnecter
                          InkWell(
                            onTap: () {
                              print("Se déconnecter");
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ), //this right here
                                    child: Container(
                                      height: 250,
                                      width: 320,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              child: Icon(
                                                Icons.warning_amber_rounded,
                                                color: red,
                                                size: 64,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              'Êtes-vous sûr de vouloir vous déconnecter',
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                /* Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 16.0,
                                                  ),
                                                  child: FlatButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      height: 40.5,
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color: blue20,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Annuler",
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: blue,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ), */
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 24.0,
                                                    right: 0,
                                                    left: 0,
                                                  ),
                                                  child: FlatButton(
                                                    onPressed: () async {
                                                      SharedPreferences _prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      await _prefs.setString(
                                                          "activeToken", '');
                                                      await _prefs.setBool(
                                                          "isLoggedIn", false);
                                                      await _prefs.setInt(
                                                          "userId", 1);
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              LoginPage(),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      height: 40.5,
                                                      width: 110,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color: red10,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Déconnexion",
                                                          style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: red,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 16,
                                right: 5.0,
                                left: 10.0,
                              ),
                              child: ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: red10,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.logout_outlined,
                                    color: red,
                                    size: 25,
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Se déconnecter",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: gray,
                                    ),
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: gray,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  void _callSAV() async {
    if (!await launch("tel://+221776738631")) throw 'Could not launch tel';
  }
}
