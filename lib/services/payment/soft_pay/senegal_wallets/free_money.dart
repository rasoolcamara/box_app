import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:box_app/models/transaction.dart';
import 'package:box_app/app_properties.dart';
import 'package:box_app/services/transaction.dart';

class FreeMoneyService {
  Future<bool> payment(
    String phone,
  ) async {
    final response = await http.post(
      Uri.parse('https://app.paydunya.com/api/v1/softpay/free-money-senegal'),
      body: jsonEncode({
        "customer_fullname": activeApplication.name,
        "customer_email": "box@box.com",
        'phone_number': phone,
        "customer_address": 'Box App',
        'payment_token': invoiceToken,
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );

    var body = jsonDecode(response.body);

    print("Payment par FREEMONEY");
    print(body);

    if (body['success'] == true) {
      // await transactionService.newTransaction(
      //     activeToken, customer, transaction);

      return body['success'];
    } else {
      return body['success'];
    }
  }
}
