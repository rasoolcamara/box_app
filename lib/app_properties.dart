import 'package:box_app/models/application.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String userURL =
    "https://preview56.paydunya.com/api/v1/"; //"http://mon-traiteur-api.test/api/";

const String baseURL = "http://3c5a-154-125-164-117.ngrok.io/";
String invoiceToken = '';
String invoiceUrl = '';
String activeToken = '';
String activeUserToken = '';
String currentCoutry = 'Sénégal';
int userId;

Application activeApplication = Application();
String appStoreUrl = "https://apps.apple.com/us/app/sendkwe/id1600051085";
String playStoreUrl =
    "https://play.google.com/store/apps/details?id=com.rasool.sendkwe";

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
