// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:box_app/app_properties.dart';
import 'package:box_app/models/wallet.dart';
import 'package:box_app/screens/home/home.dart';
import 'package:box_app/screens/payment/wizall_confirm_otp.dart';
import 'package:box_app/services/payment/checkout_invoice.dart';
import 'package:box_app/services/payment/soft_pay/bf_wallets/moov_bj.dart';
import 'package:box_app/services/payment/soft_pay/bj_wallets/mtn_bj.dart';
import 'package:box_app/services/payment/soft_pay/ci_wallets/moov_ci.dart';
import 'package:box_app/services/payment/soft_pay/ci_wallets/mtn_ci.dart';
import 'package:box_app/services/payment/soft_pay/ci_wallets/orange_money_ci.dart';
import 'package:box_app/services/payment/soft_pay/senegal_wallets/emoney.dart';
import 'package:box_app/services/payment/soft_pay/senegal_wallets/free_money.dart';
import 'package:box_app/services/payment/soft_pay/senegal_wallets/orange_money_senegal.dart';
import 'package:box_app/services/payment/soft_pay/senegal_wallets/wave_senegal.dart';
import 'package:box_app/services/payment/soft_pay/senegal_wallets/wizall_money_senegal.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({
    Key key,
    this.wallet,
  }) : super(key: key);

  final Wallet wallet;
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final FreeMoneyService freeMoneyService = FreeMoneyService();
  final EMoneyService eMoneyService = EMoneyService();
  final WaveService waveService = WaveService();
  final PaydunyaService paydunyaService = PaydunyaService();
  final WizAllService wizAllService = WizAllService();
  final OMSNService omsnService = OMSNService();
  final OMCIService omciService = OMCIService();
  final MTNCIService mtnciService = MTNCIService();
  final MoovCIService moovciService = MoovCIService();

  final MTNBJService mtnbjService = MTNBJService();
  final MoovBJService moovbjService = MoovBJService();

  final GlobalKey<FormState> _paymentFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
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
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus.unfocus();
      },
      child: Scaffold(
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
                        child: Form(
                          key: _paymentFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Email and Phone
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 60.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Numéro de téléphone",
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
                                                  TextInputType.number,
                                              autocorrect: false,
                                              autofocus: false,
                                              controller: _phoneController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(
                                                  left: 20.0,
                                                  bottom: 16,
                                                ),
                                                filled: true,
                                                fillColor: Colors.transparent,
                                                labelText: '',
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Montant",
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
                                                  TextInputType.number,
                                              autocorrect: false,
                                              autofocus: false,
                                              controller: _amountController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(
                                                  left: 20.0,
                                                  bottom: 16,
                                                ),
                                                filled: true,
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
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
                                                // suffix
                                                suffixIcon: Material(
                                                  elevation: 0,
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(30),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                      15.0,
                                                    ),
                                                    child: Text(
                                                      'FCFA',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
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
                                    setState(() {
                                      _loading = true;
                                    });
                                    final checkoutInvoice =
                                        await paydunyaService.checkoutInvoice(
                                      num.parse(_amountController.text),
                                    );
                                    if (checkoutInvoice != null) {
                                      var paymentResult = false;
                                      var paymentResultMessage = "";

                                      switch (widget.wallet.name) {
                                        case "Free Money":
                                          paymentResult = await freeMoneyService
                                              .payment(_phoneController.text);
                                          break;
                                        case "E Money":
                                          paymentResult = await eMoneyService
                                              .payment(_phoneController.text);
                                          break;
                                        case "Wave":
                                          paymentResult = await waveService
                                              .payment(_phoneController.text);
                                          break;
                                        case "ORANGE MONEY CI":
                                          paymentResultMessage =
                                              await omciService
                                                  .payment('0779077285');
                                          break;
                                        case "WizAll Money":
                                          // paymentResult = true;
                                          paymentResult = await wizAllService
                                              .paymentRequest(
                                                  _phoneController.text);
                                          print(paymentResult);
                                          break;
                                        case "MOOV CI":
                                          paymentResultMessage =
                                              await moovciService
                                                  .payment(_phoneController.text);
                                          break;
                                        case "MTN CI":
                                          paymentResult = await mtnciService
                                              .payment(_phoneController.text);
                                          break;
                                        case "MOOV BENIN":
                                          paymentResultMessage =
                                              await moovbjService
                                                  .payment(_phoneController.text);
                                          break;
                                        case "MTN BENIN":
                                          paymentResult = await mtnbjService
                                              .payment(_phoneController.text);
                                          break;
                                        default:
                                      }
                                      setState(() {
                                        _loading = false;
                                      });
                                      if (paymentResult == true) {
                                        if (widget.wallet.name ==
                                            "WizAll Money") {
                                          Navigator.of(context).push(
                                            PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  WizallOTPConfirmPage(
                                                wallet:
                                                    walletsByCountry["Sénégal"]
                                                        [3],
                                                phone: _phoneController.text,
                                              ),
                                            ),
                                          );
                                        } else {
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
                                                  height: 250,
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
                                                          child: Container(
                                                            height: 50,
                                                            width: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10.0),
                                                              ),
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    AssetImage(
                                                                  'assets/images/horloge_murale.png',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 24,
                                                        ),
                                                        Text(
                                                          'Veuillez demander à votre client de finaliser le paiement sur son téléphone!',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Roboto",
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                                                  color: orange
                                                                      .withOpacity(
                                                                          0.08),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "OK",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14.0,
                                                                      color:
                                                                          orange,
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
                                        if (widget.wallet.name == "MOOV CI") {
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
                                                  height: 240,
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
                                                          paymentResultMessage,
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
                                                  height: 240,
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
                                                          "Assurez-vous d'avoir saisi un numéro valable et ayant assez de fonds!",
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
                                      }
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
                                              height: 200,
                                              width: 320,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                      'Un problème est survenu veuillez réessayer!',
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
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
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
                                          widget.wallet.name == "WizAll Money"
                                              ? "Suivant"
                                              : "Valider",
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
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
