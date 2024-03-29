import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:box_app/models/transaction.dart';
import 'package:box_app/app_properties.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PaydunyaService {
  Future<String> checkoutInvoice(
    num totalAmount,
  ) async {
    final invoice = {
      "invoice": {
        "total_amount": totalAmount,
        "description": "Paiment de $totalAmount dépuis Box App",
      },
      "store": {
        "name": activeApplication.name,
        "phone": activeApplication.user.phoneWithIndicatif,
      },
      "custom_data": "box-service-app",
    };

    print("Génération du checkout invoice");
    print(activeApplication.user.masterKey);
    print(activeApplication.livePrivateKey);

    print(activeApplication.liveToken);

    final response = await http.post(
      Uri.parse('https://app.paydunya.com/api/v1/checkout-invoice/create'),
      body: jsonEncode(invoice),
      headers: <String, String>{
        "Content-Type": "application/json",
        "PAYDUNYA-MASTER-KEY": activeApplication.user.masterKey,
        "PAYDUNYA-PRIVATE-KEY": activeApplication.livePrivateKey,
        'PAYDUNYA-TOKEN': activeApplication.liveToken
      },
    );

    var body = jsonDecode(response.body);

    print("Génération du checkout invoice");
    print(body);
    print(body['response_code'].runtimeType);
    if (body['response_code'] == '00') {
      invoiceToken = body['token'];
      invoiceUrl = body['response_text'];
      print("le nouveau checkout invoice token\n");
      print(invoiceToken);
      print(invoiceUrl);

      return body['token'];
    } else {
      return null;
    }
  }
}
