import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:box_app/app_properties.dart';

class OMBFService {
  // final PaydunyaService service = PaydunyaService();

  Future<String> payment(
    String phone,
    String code,
  ) async {
    final response = await http.post(
      Uri.parse('https://app.paydunya.com/api/v1/softpay/orange-money-burkina'),
      body: jsonEncode({
        "name_bf": activeApplication.name,
        "email_bf": "box@box.com",
        "phone_bf": phone,
        'otp_code': code,
        'payment_token': invoiceToken,
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );

    var body = jsonDecode(response.body);

    print("Payment par OMSN");
    print(body);

    if (body['success'] == true) {
      return body['message'];
    } else {
      return body['message'];
    }
  }
}
