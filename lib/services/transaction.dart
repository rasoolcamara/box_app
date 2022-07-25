import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:box_app/models/transaction.dart';
import 'package:box_app/app_properties.dart';

class TransactionService {
  Future<List<Transactions>> getTransactions(String token) async {
    print("userId");
    print(userId);
    http.Response res = await http.get(
      Uri.parse(userURL + 'box/user/$userId/transactions'),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    print("getTransactions");
    print(json.decode(res.body));
    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      List<dynamic> data = body;
      print("data");
      print(data);
      List<Transactions> transactions = data.map(
        (dynamic item) {
          return Transactions.fromJson(item);
        },
      ).toList();

      print("getTransactions");
      print(transactions.length);

      return transactions;
    } else {
      return null;
    }
  }
}
