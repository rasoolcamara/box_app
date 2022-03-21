import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:box_app/app_properties.dart';

class OMCIService {
  Future<String> payment(
    String phone,
  ) async {
    final response = await http.post(
      Uri.parse('https://app.paydunya.com/api/v1/softpay/orange-money-ci'),
      body: jsonEncode({
        "orange_money_ci_customer_fullname": activeApplication.name,
        "orange_money_ci_email": "bow@box.com",
        "orange_money_ci_phone_number": phone,
        "orange_money_ci_wallet_provider": "ci",
        'payment_token': invoiceToken,
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );

    var body = jsonDecode(response.body);

    print("Payment par EMoney");
    print(body);

    if (body['success'] == true) {
      return body['message'];
    } else {
      return body['message'];
    }
  }
}
