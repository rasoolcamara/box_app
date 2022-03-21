import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:box_app/app_properties.dart';

class MoovBJService {
  Future<String> payment(
    String phone,
  ) async {
    final response = await http.post(
      Uri.parse('https://app.paydunya.com/api/v1/softpay/moov-benin'),
      body: jsonEncode({
        "moov_benin_customer_fullname": activeApplication.name,
        "moov_benin_email": "box@box.com",
        "moov_benin_phone_number": phone,
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
