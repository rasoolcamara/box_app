import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:box_app/app_properties.dart';

class WizAllService {
  Future<bool> paymentRequest(
    String phone,
  ) async {
    final response = await http.post(
      Uri.parse('https://app.paydunya.com/api/v1/softpay/wizall-money-senegal'),
      body: jsonEncode({
        "customer_name": activeApplication.name,
        "customer_email": "box@box.com",
        "phone_number": phone,
        'invoice_token': invoiceToken,
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );

    var body = jsonDecode(response.body);

    print("Payment par WizAll");
    print(body);

    if (body['success'] == true) {
      // return body['message'];
      return body['success'];
    } else {
      return body['success'];
    }
  }

  Future<String> payment(String phone, String code) async {
    final response = await http.post(
      Uri.parse(
          'https://app.paydunya.com/api/v1/softpay/wizall-money-senegal/confirm'),
      body: jsonEncode({
        "authorization_code": code,
        "phone_number": phone,
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );

    var body = jsonDecode(response.body);

    print("Payment Confirmé par WizAll");
    print(body);

    if (body['success'] == true) {
      return body['message'];
    } else {
      return body['message'];
    }
  }
}
