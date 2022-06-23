// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'dart:io';
import 'package:box_app/app_properties.dart';
import 'package:box_app/models/wallet.dart';
import 'package:box_app/screens/admin/disburse.dart';
import 'package:box_app/screens/home/home.dart';
import 'package:box_app/services/application.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class DisburseConnexionPage extends StatefulWidget {
  DisburseConnexionPage({
    Key key,
  }) : super(key: key);

  @override
  _DisburseConnexionPageState createState() => _DisburseConnexionPageState();
}

class _DisburseConnexionPageState extends State<DisburseConnexionPage> {
  final ApplicationService applicationServiceService = ApplicationService();

  final GlobalKey<FormState> _disburseFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final List<String> errors = [];
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
        iconTheme: IconThemeData(color: gray),
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text(
          "Connexion",
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: gray,
          ),
        ),
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(top: 10, left: 16, bottom: 8),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ),
      ),
      body: _loading
          ? spinkit
          : ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      // height: _height,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Veuillez saisir vos informations du compte PayDunya',
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Form(
                            key: _disburseFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Email and Phone
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 40.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Email ou Numéro de téléphone",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 52.5,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Theme(
                                            data: ThemeData(
                                                hintColor: Colors.transparent),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0),
                                              child: TextFormField(
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.start,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                autocorrect: false,
                                                autofocus: false,
                                                controller: _phoneController,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    left: 20.0,
                                                    bottom: 16,
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.transparent,
                                                  labelText: '',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
                                                  hintStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                  // prefixIcon: CountryCodePicker(
                                                  //   textStyle: TextStyle(
                                                  //     fontSize: 15,
                                                  //     fontWeight:
                                                  //         FontWeight.w500,
                                                  //     color: Colors.black,
                                                  //   ),
                                                  //   dialogTextStyle: TextStyle(
                                                  //     fontSize: 15,
                                                  //     fontWeight:
                                                  //         FontWeight.w500,
                                                  //     color: Colors.black,
                                                  //   ),
                                                  //   flagWidth: 30,
                                                  //   hideSearch: true,
                                                  //   dialogSize: Size(320, 300),
                                                  //   initialSelection: 'SN',
                                                  //   countryFilter: [
                                                  //     'SN',
                                                  //     'CI',
                                                  //     'BJ'
                                                  //   ],
                                                  //   onChanged: (country) {
                                                  //     _countryCode =
                                                  //         country.dialCode;
                                                  //     print(country.name);
                                                  //   },
                                                  // ),
                                                  labelStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Password
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Mot de passe",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 52.5,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Theme(
                                            data: ThemeData(
                                                hintColor: Colors.transparent),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 0.0,
                                              ),
                                              child: TextFormField(
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.start,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                autocorrect: false,
                                                autofocus: false,
                                                obscureText: true,
                                                controller: _passwordController,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    left: 20.0,
                                                    bottom: 16,
                                                  ),
                                                  filled: true,
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
                                                  fillColor: Colors.transparent,
                                                  labelText: '',
                                                  hintStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // FormError(errors: errors),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 12.0,
                                    right: 12.0,
                                    top: 65.0,
                                  ),
                                  child: FlatButton(
                                    onPressed: () async {
                                      if (_phoneController.text.isNotEmpty &&
                                          _passwordController.text.isNotEmpty) {
                                        setState(() {
                                          _loading = true;
                                        });
                                        final application =
                                            await applicationServiceService
                                                .loginWithOtherCrendentials(
                                          _passwordController.text,
                                          email: _phoneController.text,
                                        );

                                        setState(() {
                                          _loading = false;
                                        });
                                        if (application != null) {
                                          print("Athentification Réussi!");
                                          print(application.toString());

                                          Navigator.of(context).push(
                                            PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  DisbursePage(
                                                currentPassword:
                                                    _passwordController.text,
                                              ),
                                            ),
                                          );
                                        } else {
                                          print("Un problème est survenu!");

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ), //this right here
                                                child: Container(
                                                  height: 200,
                                                  width: 320,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                          child: Icon(
                                                            Icons
                                                                .warning_amber_rounded,
                                                            color: red,
                                                            size: 40,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 16,
                                                        ),
                                                        Text(
                                                          'Veuillez vérifier les données saisies!',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Roboto",
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.black,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Align(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 26.0,
                                                            ),
                                                            child: FlatButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10.0),
                                                                height: 40.5,
                                                                width: 120,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                  color: red10,
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "OK",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14.0,
                                                                      color:
                                                                          red,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ), //this right here
                                              child: Container(
                                                height: 200,
                                                width: 320,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                        child: Icon(
                                                          Icons
                                                              .warning_amber_rounded,
                                                          color: red,
                                                          size: 40,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 16,
                                                      ),
                                                      Text(
                                                        'Les champs sont obligatoires!',
                                                        style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      Align(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 26.0,
                                                          ),
                                                          child: FlatButton(
                                                            onPressed:
                                                                () async {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              height: 40.5,
                                                              width: 120,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                color: red10,
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  "OK",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                    color: red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Container(
                                        height: 55.5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: blue,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Suivant",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35.0,
                                ),
                              ],
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

  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
