import 'package:box_app/models/application.dart';
import 'package:box_app/models/wallet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String userURL =
    "https://app.paydunya.com/api/v1/"; //"http://mon-traiteur-api.test/api/";

const String baseURL = "http://3c5a-154-125-164-117.ngrok.io/";
String invoiceToken = '';
String invoiceUrl = '';
String activeToken = '';
String activeUserToken = '';
String currentCoutry = "SN";
int userId;

Map<String, List<Wallet>> walletsByCountry = {
  "SN": [],
  "CI": [],
  "BJ": [],
  "BF": [],
  "TG": [],
  "ML": [],
  "INTERNATIONAL": [],
};

Map<String, String> walletsLogo = {
  "orange-money-senegal": 'assets/images/logo-part/orange-money.png',
  "orange-money-burkina": 'assets/images/logo-part/orange-money.png',
  "expresso-sn": 'assets/images/logo-part/emoney.png',
  "free-money-senegal": 'assets/images/logo-part/free-money.png',
  "wave-senegal": 'assets/images/logo-part/wave.png',
  "moov-burkina-faso": 'assets/images/logo-part/moov.png',
  "moov-bj": 'assets/images/logo-part/moov.png',
  "moov-benin": 'assets/images/logo-part/moov.png',
  "moov-ci": 'assets/images/logo-part/moov.png',
  "mtn-ci": 'assets/images/logo-part/mtn.png',
  "mtn-bj": 'assets/images/logo-part/mtn.png',
  "mtn-benin": 'assets/images/logo-part/mtn.png',
  "moov-ml": 'assets/images/logo-part/moov.png',
  "moov-bf": 'assets/images/logo-part/moov.png',
  "wizall-senegal": 'assets/images/logo-part/wizall.png',
  "orange-money-ci": 'assets/images/logo-part/orange-money.png',
};

Application activeApplication = Application();

String paydunyaMasterKey = 'WgedBb3h-KMie-lsNN-XCTj-jMUg1tcPkHs8';
String paydunyaPrivateKey = 'live_private_LjGl1jBePaFHmJMPQcBsYWoNWgg';
String paydunyaToken = '7v1HHSJSbyT2kR8xjrkr';
String cancelUrl = baseURL + 'api/payment/cancel';
String returnUrl = baseURL + 'api/payment/return';
String callbackUrl = baseURL + 'api/callback';

const Color blue = Color(0xff0070B2);
const Color blue10 = Color.fromRGBO(0, 112, 178, 0.05);
const Color blue20 = Color.fromRGBO(0, 112, 178, 0.08);
const Color red = Color(0xffF0142F);
const Color red10 = Color.fromRGBO(178, 0, 0, 0.08);
const Color orange = Color(0xffFC8104);
const Color gray10 = Color.fromRGBO(233, 233, 240, 1);
const Color gray = Color(0xff131523);
const Color white = Color(0xffF3F4F5);
const Color black = Color(0xffF3F4F5);
const Color green = Color(0xff1FB552);
