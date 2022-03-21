import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:box_app/models/transaction.dart';
import 'package:box_app/app_properties.dart';
import 'package:box_app/services/transaction.dart';

class MTNBJService {
  Future<bool> payment(
    String phone,
  ) async {
    final response = await http.post(
      Uri.parse('https://app.paydunya.com/api/v1/softpay/mtn-benin'),
      body: jsonEncode({
        "mtn_benin_customer_fullname": activeApplication.name,
        "mtn_benin_email": "box@box.com",
        "mtn_benin_phone_number": phone,
        "mtn_benin_wallet_provider": "MTNBENIN",
        'payment_token': invoiceToken,
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );

    var body = jsonDecode(response.body);

    print("Payment par MTNBENIN");
    print(body);

    if (body['success'] == true) {
      return body['success'];
    } else {
      throw body;
    }
  }
}
