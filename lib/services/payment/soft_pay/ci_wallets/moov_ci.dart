import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:box_app/app_properties.dart';

class MoovCIService {
  Future<String> payment(
    String phone,
  ) async {
    final response = await http.post(
      Uri.parse('https://app.paydunya.com/api/v1/softpay/moov-ci'),
      body: jsonEncode({
        "moov_ci_customer_fullname": activeApplication.name,
        "moov_ci_email": "box@box.com",
        "moov_ci_phone_number": phone,
        'payment_token': invoiceToken,
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );

    var body = jsonDecode(response.body);

    print("Payment par MOOVCI");
    print(body);

    if (body['success'] == true) {
      return body['message'];
    } else {
      return body['message'];
    }
  }
}
