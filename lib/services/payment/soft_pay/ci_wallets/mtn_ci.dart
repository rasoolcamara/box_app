import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:box_app/models/transaction.dart';
import 'package:box_app/app_properties.dart';
import 'package:box_app/services/transaction.dart';

class MTNCIService {
  Future<bool> payment(
    String phone,
  ) async {
    final response = await http.post(
      Uri.parse('https://app.paydunya.com/api/v1/softpay/mtn-ci'),
      body: jsonEncode({
        "mtn_ci_customer_fullname": activeApplication.name,
        "mtn_ci_email": "box@box.com",
        "mtn_ci_phone_number": phone,
        "mtn_ci_wallet_provider": "MTNCI",
        'payment_token': invoiceToken,
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );


    print("Payment par MTNCI");
    print(response.body);
    var body = jsonDecode(response.body);

    print("Payment par MTNCI");
    print(body);

    if (body['success'] == true) {
      return body['success'];
    } else {
      // throw body;
      return body['success'];
    }
  }
}
