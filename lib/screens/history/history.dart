// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:box_app/app_properties.dart';
import 'package:box_app/models/transaction.dart';
import 'package:box_app/models/wallet.dart';
import 'package:box_app/screens/history/transaction.dart';
import 'package:box_app/screens/home/home.dart';
import 'package:box_app/services/transaction.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final TransactionService transactionService = TransactionService();

  final TextEditingController _searchController = TextEditingController();

  final List<String> errors = [];
  String _countryCode = "+221";

  bool _loading = false;
  bool _searching = false;
  List<Transactions> searchingTransactions = [];

  final spinkit = SpinKitRing(
    color: orange.withOpacity(0.5),
    lineWidth: 10.0,
    size: 100.0,
  );
  // SpinKitCircle(
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
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            "Historique des transactions",
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
      body: FutureBuilder(
        future: transactionService.getTransactions(activeToken),
        builder: (_, snapshot) {
          if (snapshot.data != null) {
            List<Transactions> transactions = snapshot.data;
            return ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      // height: _height,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          _search(context, transactions),
                          SizedBox(
                            height: 16,
                          ),
                          _latestTransactions(
                            context,
                            _searching ? searchingTransactions : transactions,
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

  /// Item TextFromField Search
  Padding _search(BuildContext context, List<Transactions> transactions) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 5.0, left: 5.0),
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
          border: Border.all(
            color: gray,
            width: 1.0,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                controller: _searchController,
                onChanged: (value) {
                  print(value);
                  setState(() {
                    _searching = true;
                    searchingTransactions = transactions
                        .where(
                          (Transactions transaction) =>
                              transaction.customerPhone.contains(value),
                        )
                        .toList();
                  });
                },
                onFieldSubmitted: (value) => {
                  _searchController.clear(),
                  setState(() {
                    _searching = false;
                  }),
                },
                style: TextStyle(
                  color: gray,
                  fontSize: 13.0,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: gray,
                    size: 28.0,
                  ),
                  hintText: "Rechercher avec le numéro",
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                    color: gray.withOpacity(0.5),
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
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
        // bottom: 10,
        // left: 10,
        // right: 10,
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
