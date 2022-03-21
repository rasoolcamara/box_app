import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:box_app/models/customer.dart';
import 'package:box_app/models/transaction.dart';
import 'package:box_app/app_properties.dart';
import 'package:box_app/services/transaction.dart';

class EMoneyService {
  Future<bool> payment(
    String phone,
  ) async {
    final response = await http.post(
      Uri.parse('https://app.paydunya.com/api/v1/softpay/expresso-senegal'),
      body: jsonEncode({
        "expresso_sn_fullName": activeApplication.name,
        "expresso_sn_email": "box@box.com",
        "expresso_sn_phone": phone,
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
      // await transactionService.newTransaction(
      //     activeToken, customer, transaction);

      return body['success'];
    } else {
      return body['success'];
    }
  }
}
