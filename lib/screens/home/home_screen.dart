// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:box_app/app_properties.dart';
import 'package:box_app/models/transaction.dart';
import 'package:box_app/models/wallet.dart';
import 'package:box_app/screens/history/transaction.dart';
import 'package:box_app/screens/home/home.dart';
import 'package:box_app/screens/payment/dmp.dart';
import 'package:box_app/screens/payment/payment.dart';
import 'package:box_app/services/transaction.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key key}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  final TransactionService transactionService = TransactionService();

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   brightness: Brightness.dark,
      //   iconTheme: IconThemeData(color: Colors.white),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      //   // title: Text(
      //   //   "Box",
      //   //   style: TextStyle(
      //   //     fontFamily: "Roboto",
      //   //     fontSize: 20.0,
      //   //     fontWeight: FontWeight.w600,
      //   //     color: Colors.white,
      //   //   ),
      //   // ),
      //   // leading: new IconButton(
      //   //   icon: new Icon(Icons.ac_unit),
      //   //   onPressed: () => Navigator.of(context).pop(),
      //   // ),
      //   elevation: 0.0,
      // ),
      body: FutureBuilder(
        future: transactionService.getTransactions(activeToken),
        builder: (_, snapshot) {
          print("SnapSHOT");
          print(snapshot.data);
          if (snapshot.data != null) {
            List<Transactions> transactions = snapshot.data;
            return ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      // height: _height,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/home.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              // color: Colors.transparent.withOpacity(0.1),
                            ),
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 16.0,
                              right: 16.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Bienvenu sur votre Box",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  activeApplication.user.name,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // _walletsCards(context),
                          Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 16.0,
                              right: 16.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                PaymentPage(
                                              wallet:
                                                  walletsByCountry["Sénégal"]
                                                      [0],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Material(
                                        elevation: 5,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                        child: Container(
                                          height: 85,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(50),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: gray.withOpacity(0.1),
                                                blurRadius: 4.0,
                                                spreadRadius: 0.0,
                                                offset: Offset(0.0, 0.0),
                                              )
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Image(
                                              image: AssetImage(
                                                walletsByCountry["Sénégal"][0]
                                                    .logo,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                PaymentPage(
                                              wallet:
                                                  walletsByCountry["Sénégal"]
                                                      [1],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Material(
                                        elevation: 5,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                        child: Container(
                                          height: 85,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(50),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: gray.withOpacity(0.1),
                                                blurRadius: 4.0,
                                                spreadRadius: 0.0,
                                                offset: Offset(0.0, 0.0),
                                              )
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Image(
                                              image: AssetImage(
                                                walletsByCountry["Sénégal"][1]
                                                    .logo,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                PaymentPage(
                                              wallet:
                                                  walletsByCountry["Sénégal"]
                                                      [2],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Material(
                                        elevation: 5,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                        child: Container(
                                          height: 85,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(50),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: gray.withOpacity(0.1),
                                                blurRadius: 4.0,
                                                spreadRadius: 0.0,
                                                offset: Offset(0.0, 0.0),
                                              )
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Image(
                                              image: AssetImage(
                                                walletsByCountry["Sénégal"][2]
                                                    .logo,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                PaymentPage(
                                              wallet:
                                                  walletsByCountry["Sénégal"]
                                                      [3],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Material(
                                        elevation: 5,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                        child: Container(
                                          height: 85,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(50),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: gray.withOpacity(0.1),
                                                blurRadius: 4.0,
                                                spreadRadius: 0.0,
                                                offset: Offset(0.0, 0.0),
                                              )
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Image(
                                              image: AssetImage(
                                                walletsByCountry["Sénégal"][3]
                                                    .logo,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                PaymentPage(
                                              wallet:
                                                  walletsByCountry["Sénégal"]
                                                      [4],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Material(
                                        elevation: 5,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                        child: Container(
                                          height: 85,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(50),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: gray.withOpacity(0.1),
                                                blurRadius: 4.0,
                                                spreadRadius: 0.0,
                                                offset: Offset(0.0, 0.0),
                                              )
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Image(
                                              image: AssetImage(
                                                walletsByCountry["Sénégal"][4]
                                                    .logo,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50.0),
                                          ),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 0.0,
                                          ),
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Colors.black12,
                                          //     blurRadius:
                                          //         30.0, // soften the shadow
                                          //     spreadRadius:
                                          //         1.0, //extend the shadow
                                          //     offset: Offset(
                                          //       0.0, // Move to right 10  horizontally
                                          //       0.0, // Move to bottom 10 Vertically
                                          //     ),
                                          //   )
                                          // ],
                                        ),
                                        child: Image(
                                          height: 80,
                                          width: 80,
                                          color: Colors.white,
                                          image: AssetImage(
                                            walletsByCountry["Sénégal"][1].logo,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(2.0),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.link,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder: (_, __, ___) => DmpPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Demander un paiement à distance",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 50),
                                child: Text(
                                  "Dernière transactions",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: gray,
                                  ),
                                ),
                              ),
                              _latestTransactions(
                                context,
                                transactions.take(3).toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(
              child: spinkit,
            );
          }
        },
      ),
    );
  }

  Container _walletsCards(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 26.0, right: 0.0, left: 0.0),
      width: MediaQuery.of(context).size.width,
      height: 240,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProgressButton(
                color: Colors.white,
                progressIndicatorColor: blue,
                borderRadius: BorderRadius.all(Radius.circular(60)),
                strokeWidth: 1,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        walletsByCountry["Sénégal"][0].logo,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                onPressed: (AnimationController controller) async {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => PaymentPage(
                        wallet: walletsByCountry["Sénégal"][0],
                      ),
                    ),
                  );
                  // controller.forward();
                },
              ),
              ProgressButton(
                color: Colors.white,
                progressIndicatorColor: blue,
                borderRadius: BorderRadius.all(Radius.circular(60)),
                strokeWidth: 1,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        walletsByCountry["Sénégal"][0].logo,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                onPressed: (AnimationController controller) async {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => PaymentPage(
                        wallet: walletsByCountry["Sénégal"][0],
                      ),
                    ),
                  );
                  // controller.forward();
                },
              ),
              ProgressButton(
                color: Colors.white,
                progressIndicatorColor: blue,
                borderRadius: BorderRadius.all(Radius.circular(60)),
                strokeWidth: 1,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        walletsByCountry["Sénégal"][0].logo,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                onPressed: (AnimationController controller) async {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => PaymentPage(
                        wallet: walletsByCountry["Sénégal"][0],
                      ),
                    ),
                  );
                  // controller.forward();
                },
              ),
            ],
          ),

          /* SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 240,
            child: 
            /* GridView.count(
              crossAxisCount: 3,
              primary: false,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              childAspectRatio: 1.1,
              children: List.generate(
                walletsByCountry["Sénégal"].length,
                (index) {
                  Wallet wallet = walletsByCountry["Sénégal"][index];
                  return Container(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 8.0,
                      bottom: 5.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black12,
                      //     blurRadius: 1.0, // soften the shadow
                      //     spreadRadius: 1.0, //extend the shadow
                      //     offset: Offset(
                      //       0.0, // Move to right 10  horizontally
                      //       0.0, // Move to bottom 10 Vertically
                      //     ),
                      //   )
                      // ],
                    ),
                    child: ProgressButton(
                      color: Colors.white,
                      progressIndicatorColor: blue,
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      strokeWidth: 1,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              wallet.logo,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      onPressed: (AnimationController controller) async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PaymentPage(
                              wallet: wallet,
                            ),
                          ),
                        );
                        // controller.forward();
                      },
                    ),
                  );

                  /* InkWell(
                    onTap: () async {
                      if (wallet.name == "Orange Money Sénégal") {
                        print("On envoi la requete");
                        final theToken = await sendingSMSService.authCRM();

                        // final result = await oMSNService.sendUssdRequest();
                        print("The result for OMSN sending sms: \n\n");
                        print(theToken);
                        if (theToken != 'null') {
                          final result = await sendingSMSService.sendSMS(
                            "+221772948083",
                            "Paiement avec Orange Money Sénégal sur +221772948083 invoice " +
                                invoiceToken +
                                " token",
                            theToken,
                          );

                          print("The result for OMSN sending sms: \n\n");
                          print(result);
                        }

                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.SUCCES,
                          animType: AnimType.RIGHSLIDE,
                          headerAnimationLoop: true,
                          title: 'Alerte',
                          desc:
                              'Le paiement OM Sénégal est initié avec succés !',
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.done,
                          btnOkColor: Colors.green,
                        )..show();
                      } else if (wallet.name == "WizAll Money") {
                        print("On lance la requete");

                        final result =
                            await wizallService.paymentRequest("774731921");

                        print("Le result du paiement par WizAll est: \n");
                        print(result);
                        print("Le result du paiement par WizAll est: \n");
                      } else if (wallet.name == "E Money") {
                        print("On lance la requete");

                        final result = await eMoneyService.payment("774731921");

                        print("Le result du paiement par Expresso est: \n");
                        print(result);
                        print("Le result du paiement par Expresso est: \n");
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.SUCCES,
                          animType: AnimType.RIGHSLIDE,
                          headerAnimationLoop: true,
                          title: 'Alerte',
                          desc: 'Le paiement E-Money est initié avec succés !',
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.done,
                          btnOkColor: Colors.green,
                        )..show();
                      } else if (wallet.name == "Free Money") {
                        print("On lance la requete");

                        final result =
                            await freeMoneyService.payment("768166591");

                        print("Le result du paiement par Free Money est: \n");
                        print(result);
                        print("Le result du paiement par Free Money est: \n");

                        if (result) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.SUCCES,
                            animType: AnimType.RIGHSLIDE,
                            headerAnimationLoop: true,
                            title: 'Merci',
                            desc:
                                'Le paiement FreeMoney est initié avec succés !',
                            btnOkOnPress: () {},
                            btnOkIcon: Icons.done,
                            btnOkColor: Colors.green,
                          )..show();
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            animType: AnimType.RIGHSLIDE,
                            headerAnimationLoop: true,
                            title: 'Alerte',
                            desc:
                                "Le paiement FreeMoney n'a pas pu être initié, vérifiez le solde du numéro payeur!",
                            btnOkOnPress: () {},
                            btnOkIcon: Icons.cancel,
                            btnOkColor: Colors.red,
                          )..show();
                        }
                      }
                    },
                    child: itemCard(
                      image: wallet.logo,
                      title: wallet.name,
                    ),
                  ); */
                },
              ),
            ), */
          ), */
        ],
      ),
    );
  }

  Padding _latestTransactions(
      BuildContext context, List<Transactions> transactions) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 20, left: 5, right: 5),
      child: transactions.isEmpty
          ? Container(
              padding: EdgeInsets.only(top: 16, left: 8, right: 8),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 25.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      1.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
                color: Colors.white,
              ),
              width: double.infinity,
              child: Center(
                child: Text(
                  "Aucune transaction",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: gray.withOpacity(0.4),
                  ),
                ),
              ))
          : Container(
              padding: EdgeInsets.only(top: 16, left: 8, right: 8),
              // height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 25.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      1.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
                color: Colors.white,
              ),
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  Transactions transaction = transactions[index];
                  return buildList(
                    context,
                    transaction,
                    index == transactions.length - 1,
                  );
                },
              ),
            ),
    );
  }

  // History
  Widget buildList(
    BuildContext context,
    Transactions transaction,
    bool isTheLast,
  ) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
          topLeft: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
      child: Column(
        children: <Widget>[
          _historyItem(context, transaction),
          !isTheLast
              ? Divider(
                  color: Colors.black38,
                )
              : Divider(
                  color: Colors.white,
                ),
        ],
      ),
    );
  }

  Widget _historyItem(BuildContext context, Transactions transaction) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => TransactionPage(
              transaction: transaction,
            ),
          ),
        );
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.only(
          top: 5,
          bottom: 0,
          left: 10,
          right: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  transaction.customerPhone,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  _formatDate(DateTime.parse(transaction.date)),
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  _formatCurrencyForList(transaction.amount),
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                transaction.status == "success"
                    ? Text(
                        "Succès",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: green,
                        ),
                      )
                    : transaction.status == "pending"
                        ? Text(
                            "En cours",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: orange,
                            ),
                          )
                        : Text(
                            "Échec",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: red,
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
    _passwordController.dispose();
    super.dispose();
  }
}

String _formatDate(DateTime date) {
  final format = DateFormat('dd/MM/yyyy HH:mm:ss');
  return format.format(date);
}

String _formatCurrencyForList(num amount) {
  var f = new NumberFormat.currency(
      locale: "fr-FR", symbol: "FCFA", decimalDigits: 0);
  return '${f.format(amount)}';
}


/* 
GridView.builder(
              itemCount: walletsByCountry["Sénégal"].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                Wallet wallet = walletsByCountry["Sénégal"][index];

                return Container(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    top: 8.0,
                    bottom: 5.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black12,
                    //     blurRadius: 1.0, // soften the shadow
                    //     spreadRadius: 1.0, //extend the shadow
                    //     offset: Offset(
                    //       0.0, // Move to right 10  horizontally
                    //       0.0, // Move to bottom 10 Vertically
                    //     ),
                    //   )
                    // ],
                  ),
                  child: ProgressButton(
                    color: Colors.white,
                    progressIndicatorColor: blue,
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    strokeWidth: 1,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            wallet.logo,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onPressed: (AnimationController controller) async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PaymentPage(
                            wallet: wallet,
                          ),
                        ),
                      );
                      // controller.forward();
                    },
                  ),
                );
              },
            ),

 */