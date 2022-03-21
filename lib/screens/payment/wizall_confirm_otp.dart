// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'dart:io';
import 'package:box_app/app_properties.dart';
import 'package:box_app/models/wallet.dart';
import 'package:box_app/screens/home/home.dart';
import 'package:box_app/services/payment/checkout_invoice.dart';
import 'package:box_app/services/payment/soft_pay/senegal_wallets/emoney.dart';
import 'package:box_app/services/payment/soft_pay/senegal_wallets/free_money.dart';
import 'package:box_app/services/payment/soft_pay/senegal_wallets/orange_money_senegal.dart';
import 'package:box_app/services/payment/soft_pay/senegal_wallets/wave_senegal.dart';
import 'package:box_app/services/payment/soft_pay/senegal_wallets/wizall_money_senegal.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:url_launcher/url_launcher.dart';

class WizallOTPConfirmPage extends StatefulWidget {
  WizallOTPConfirmPage({
    Key key,
    this.wallet,
    this.phone,
  }) : super(key: key);

  final Wallet wallet;
  final String phone;
  @override
  _WizallOTPConfirmPageState createState() => _WizallOTPConfirmPageState();
}

class _WizallOTPConfirmPageState extends State<WizallOTPConfirmPage> {
  final PaydunyaService paydunyaService = PaydunyaService();
  final FreeMoneyService freeMoneyService = FreeMoneyService();
  final EMoneyService eMoneyService = EMoneyService();
  final WaveService waveService = WaveService();
  final WizAllService wizAllService = WizAllService();
  final OMSNService omsnService = OMSNService();

  final GlobalKey<FormState> _paymentFormKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController(text: "");

  final List<String> errors = [];
  String _countryCode = "+221";
  String otpCode;
  bool _loading = false;

  final spinkit = SpinKitRing(
    color: orange.withOpacity(0.5),
    lineWidth: 10.0,
    size: 100.0,
  );

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
          widget.wallet.name,
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
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  'Confirmer la transaction',
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
                                  'Veillez saisir le code sms reçu par votre client sur le ${widget.phone}',
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    color: gray,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 45,
                                ),
                                Text(
                                  "Saisissez le code",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Form(
                            key: _paymentFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // OTP Fields
                                Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: Center(
                                    child: PinCodeTextField(
                                      backgroundColor: Colors.white,
                                      appContext: context,
                                      length: 5,
                                      obscureText: false,
                                      autoFocus: true,
                                      hintCharacter: '•',
                                      hintStyle: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      blinkWhenObscuring: false,
                                      animationType: AnimationType.fade,
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.underline,
                                        borderWidth: 3.0,
                                        activeFillColor: Colors.white,
                                        activeColor: gray.withOpacity(0.3),
                                        inactiveFillColor: Colors.white,
                                        inactiveColor: gray.withOpacity(0.3),
                                        selectedFillColor: Colors.white,
                                        selectedColor: blue,
                                      ),
                                      cursorColor: Colors.black,
                                      animationDuration:
                                          Duration(milliseconds: 300),
                                      enableActiveFill: true,
                                      // errorAnimationController: errorController,
                                      // controller: textEditingController,
                                      keyboardType: TextInputType.number,

                                      onCompleted: (value) {
                                        print("Completed");
                                        setState(() {
                                          otpCode = value;
                                        });
                                      },
                                      // onTap: () {
                                      //   print("Pressed");
                                      // },
                                      onChanged: (value) {
                                        print(value);
                                        setState(() {
                                          // currentText = value;
                                        });
                                      },
                                      beforeTextPaste: (text) {
                                        print("Allowing to paste $text");
                                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                        return true;
                                      },
                                    ),
                                  ),
                                ),

                                // FormError(errors: errors),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 12.0,
                                    right: 12.0,
                                    top: 45.0,
                                  ),
                                  child: FlatButton(
                                    onPressed: () async {
                                      setState(() {
                                        _loading = true;
                                      });

                                      final result = await wizAllService
                                          .payment(widget.phone, otpCode);
                                      print(result);

                                      setState(() {
                                        _loading = false;
                                      });

                                      if (result != null) {
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
                                                            .start,
                                                    children: [
                                                      Align(
                                                        child: Icon(
                                                          Icons.done,
                                                          color: green,
                                                          size: 40,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 16,
                                                      ),
                                                      Text(
                                                        'Paiement effectué avec succès!',
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
                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacement(
                                                                MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      HomeScreen(),
                                                                ),
                                                              );
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
                                                                color: green
                                                                    .withOpacity(
                                                                        0.08),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  "Merci",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                    color:
                                                                        green,
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
                                      } else {
                                        print("Un problème est survenu!");
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ), //this right here
                                              child: Container(
                                                height: 240,
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
                                                        "Assurez-vous d'avoir saisi un numéro valable et ayant assez de fonds!",
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
                                            "Valider",
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
    controller.dispose();
    super.dispose();
  }
}
