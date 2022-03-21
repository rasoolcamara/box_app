import 'dart:convert';
import 'package:box_app/models/application.dart';
import 'package:box_app/services/application.dart';
import 'package:http/http.dart' as http;
import 'package:box_app/models/transaction.dart';
import 'package:box_app/app_properties.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ApiPushService {
  Future<String> disburseInitiation(
    num totalAmount,
    String phone,
  ) async {
    final response = await http.post(
      Uri.parse('https://app.paydunya.com/api/v1/disburse/get-invoice'),
      body: jsonEncode({
        "account_alias": activeApplication.user.phoneWithIndicatif,
        "amount": totalAmount,
        "withdraw_mode": activeApplication.withdrawWallet.slug
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

    print("Génération du checkout invoice");
    print(body);
    print(body['response_code'].runtimeType);
    if (body['response_code'] == '00') {
      var respon = await disburseSubmit(body['disburse_token']);
      return respon;
    } else {
      return null;
    }
  }

  Future<String> disburseSubmit(
    String token,
  ) async {
    final response = await http.post(
      Uri.parse('https://app.paydunya.com/api/v1/disburse/submit-invoice'),
      body: jsonEncode({
        "disburse_invoice": token,
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

    print("Génération du checkout invoice");
    print(body);

    if (body['response_code'] == '00') {
      await ApplicationService().getApplication(
        activeToken,
        activeApplication.user.id,
      );
      return body['response_text'];
    } else {
      return body['response_text'];
    }
  }

  Future<String> disburse(
    num totalAmount,
    String currentPassword,
  ) async {
    print("THE CURRENT PASSWORD");
    print(currentPassword);
    final response = await http.post(
      Uri.parse('https://preview56.paydunya.com/api/v1/withdraws'),
      body: jsonEncode({
        "amount": totalAmount.toString(),
        "current_password": currentPassword,
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $activeUserToken"
      },
    );

    print("Génération du checkout invoice");
    print(response.body);
    var body = jsonDecode(response.body);

    print(body['success'].runtimeType);
    if (body['success']) {
      return body['message'];
    } else {
      return body['message'];
    }
  }

  /* https://paydunya.test/api/v1/withdraws
payload {
amount:
current_password:
} */
}
