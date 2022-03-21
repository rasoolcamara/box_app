import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:box_app/app_properties.dart';

class MoovBFService {
  Future<String> payment(
    String phone,
  ) async {
    final response = await http.post(
      Uri.parse('https://paydunya.com/api/v1/softpay/moov-burfina'),
      body: jsonEncode({
        "moov_burkina_faso_fullName": activeApplication.name,
        "moov_burkina_faso_email": "box@box.com",
        "moov_burkina_faso_phone_number": phone,
        'moov_burkina_faso_payment_token': invoiceToken,
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );

    var body = jsonDecode(response.body);

    print("Payment par MOOVBF");
    print(body);

    if (body['success'] == true) {
      return body['message'];
    } else {
      return body['message'];
    }
  }
}
