import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:box_app/models/transaction.dart';
import 'package:box_app/app_properties.dart';
import 'package:box_app/services/transaction.dart';

class OMSNService {
  Future<String> payment(String phone, String code, Transactions transaction,
      {String name, String email}) async {
    final response = await http.post(
      Uri.parse('https://app.paydunya.com/api/v1/softpay/orange-money-senegal'),
      body: jsonEncode({
        "customer_name": name,
        "customer_email": email,
        "phone_number": phone,
        'authorization_code': code,
        'invoice_token': invoiceToken,
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );

    var body = jsonDecode(response.body);

    print("Payment par OMSN");
    print(body);

    if (body['success'] == true) {
      // await transactionService.newTransaction(
      //     activeToken, customer, transaction);
      return body['message'];
    } else {
      return body['message'];
    }
  }
}
