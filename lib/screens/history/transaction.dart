// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:io';
import 'package:box_app/app_properties.dart';
import 'package:box_app/models/transaction.dart';
import 'package:box_app/models/wallet.dart';
import 'package:box_app/screens/home/home.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionPage extends StatefulWidget {
  TransactionPage({
    Key key,
    this.transaction,
  }) : super(key: key);
  Transactions transaction;

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  // final UserService userService = UserService();

  final TextEditingController _searchController = TextEditingController();

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
          "Details de la transaction",
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
            height: 40,
            width: 40,
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
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: _height,
                    width: double.infinity,
                    // padding: const EdgeInsets.only(bottom: 100.0),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        // Montant
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 16.0),
                          child: Text(
                            _formatCurrency(
                                num.parse(widget.transaction.amount)),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: gray,
                            ),
                          ),
                        ),
                        // Phone
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            top: 25.0,
                            bottom: 16,
                          ),
                          child: Text(
                            "Paiement de " + widget.transaction.customerPhone,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: gray,
                            ),
                          ),
                        ),
                        // Payment Method
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                "Moyen de paiement",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: gray,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              widget.transaction.wallet,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: gray,
                              ),
                            ),
                          ),
                        ),
                        // Fees
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                "Frais",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: gray,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              "100 FCFA",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: gray,
                              ),
                            ),
                          ),
                        ),
                        // Status
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                "Statut",
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: gray,
                                ),
                              ),
                            ),
                            subtitle: widget.transaction.status == "completed"
                                ? Text(
                                    "Succès",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: green,
                                    ),
                                  )
                                : widget.transaction.status == "pending"
                                    ? Text(
                                        "En cours",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: red,
                                        ),
                                      )
                                    : Text(
                                        "Échec",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: red,
                                        ),
                                      ),
                          ),
                        ),
                        // Date
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                "Date ",
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: gray,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              _formatDate(
                                  DateTime.parse(widget.transaction.date)),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: gray,
                              ),
                            ),
                          ),
                        ),
                        // Reference
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                "Réference",
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: gray,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              widget.transaction.identifier,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: gray,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

String _formatDate(DateTime date) {
  final format = DateFormat('dd/MM/yyyy HH:mm:ss');
  return format.format(date);
}

String _formatCurrencyForList(num amount) {
  var f =
      NumberFormat.currency(locale: "fr-FR", symbol: "FCFA", decimalDigits: 0);
  return f.format(amount);
}

String _formatCurrency(num amount) {
  var f =
      NumberFormat.currency(locale: "fr-FR", symbol: "Fcfa", decimalDigits: 0);
  return f.format(amount);
}
