import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:box_app/app_properties.dart';

class ApiDMPService {
  Future<String> fastDmpSending(
    num totalAmount,
    String alias, {
    String phone,
    String email,
  }) async {
    print("TESTTTTT $alias");
    final response = await http.post(
      Uri.parse('https://app.paydunya.com/api/v1/dmp'),
      body: jsonEncode({
        "phone": activeApplication.user.phone,
        "account_alias": alias,
        "amount": totalAmount,
        'supported_by_business': 0,
        'service': 'box-app-service',
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":
            "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjI3MTAwNSwiaXNzIjoiaHR0cHM6XC9cL2FwcC5wYXlkdW55YS5jb21cL2FwaVwvdjFcL2F1dGhlbnRpY2F0ZSIsImlhdCI6MTY0NjY2NTY2MSwiZXhwIjoxOTYyMDI1NjYxLCJuYmYiOjE2NDY2NjU2NjEsImp0aSI6IjYxN2EwZjY4ZjEyNDFjYjVlZWUyNWJmZjc0MGE5NjQzIn0.tHhllRZI1kfx5ZumqfJPOiUrwyVRuVfrfGD7ryzasfY",
        // "Authorization": "Bearer $activeToken",
      },
    );

    var body = jsonDecode(response.body);

    print("API DMP");
    print(body);

    if (body['success'] == true) {
      return body['message'];
    } else {
      return null;
    }
  }

  Future<String> dmpSending(
    num totalAmount, {
    String phone,
    String email,
  }) async {
    final response = await http.post(
      Uri.parse('https://app.paydunya.com/api/v1/dmp-api'),
      body: jsonEncode({
        "recipient_email": email,
        "recipient_phone": phone,
        "amount": totalAmount,
        "support_fees ": 0,
        "send_notification": 1,
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
        "PAYDUNYA-MASTER-KEY": paydunyaMasterKey,
        "PAYDUNYA-PRIVATE-KEY": paydunyaPrivateKey,
        'PAYDUNYA-TOKEN': paydunyaToken
        // "PAYDUNYA-MASTER-KEY": activeApplication.user.masterKey,
        // "PAYDUNYA-PRIVATE-KEY": activeApplication.livePrivateKey,
        // 'PAYDUNYA-TOKEN': activeApplication.liveToken,
      },
    );

    var body = jsonDecode(response.body);

    print("API DMP");
    print(body);

    if (body['success'] == true) {
      return body['message'];
    } else {
      return null;
    }
  }
}
