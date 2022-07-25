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
        "account_alias": alias,
        "amount": totalAmount,
        'supported_by_business': 0,
        'service': 'box-service-app',
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $activeToken",
      },
    );
    print("response.body");
    print(response.body);

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
