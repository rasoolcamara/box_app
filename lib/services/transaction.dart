import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:box_app/models/transaction.dart';
import 'package:box_app/app_properties.dart';

class TransactionService {
  Future<List<Transactions>> getTransactions(String token) async {
    http.Response res = await http.get(
      Uri.parse(userURL + 'box/user/$userId/transactions'),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    print("DATA");
    print(res.body);

    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      List<dynamic> data = body;

      List<Transactions> transactions = data
          .map(
            (dynamic item) => Transactions.fromJson(item),
          )
          .toList();

      return transactions;
    } else {
      return null;
    }
  }
}
