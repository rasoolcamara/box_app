import 'package:box_app/app_properties.dart';
import 'package:box_app/models/wallet.dart';

class Transactions {
  final int id;
  final String identifier;
  // final Wallet wallet;
  final String wallet;
  final String customerPhone;
  final String customerName;
  final String customerEmail;
  final String token;
  final String paydunyaRequestToken;
  final String amount;
  final String totalAmount;
  final String date;
  final String status;

  Transactions({
    this.id,
    this.identifier,
    this.customerPhone,
    this.customerName,
    this.customerEmail,
    this.token,
    this.paydunyaRequestToken,
    this.wallet,
    this.amount,
    this.totalAmount,
    this.date,
    this.status,
  });

  factory Transactions.fromJson(Map<String, dynamic> json) {
    try {
      print("json['created_at']['date']");
      print(json['created_at']);
      return Transactions(
        id: json['id'] as int,
        identifier: json['identifier'] as String,
        customerPhone: json['customer_phone'] as String,
        customerName: json['customer_name'] as String,
        customerEmail: json['customer_email'] as String,
        token: json['token'] as String,
        paydunyaRequestToken: json['payment_request_token'] as String,
        wallet: json['payment_method'],
        amount: json['amount'] as String,
        totalAmount: json['amount_without_fees'] as String,
        date: json['created_at'] as String,
        status: json['status'] as String,
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }
}

/* List<Transactions> transactions = [
  Transactions(
    id: 1,
    identifier: '87489568548235',
    phone: '+221 77 715 86 73',
    wallet: walletsSenegal.first,
    amount: 1000,
    date: '12/02/2022 - 8H 10',
    status: 'success',
  ),
  Transactions(
    id: 2,
    identifier: '87489568548235',
    phone: '+221 77 715 86 73',
    wallet: walletsSenegal.first,
    amount: 1000,
    date: '12/02/2022 - 8H 10',
    status: 'failed',
  ),
  Transactions(
    id: 3,
    identifier: '87489568548235',
    phone: '+221 77 715 86 73',
    wallet: walletsSenegal.first,
    amount: 1000,
    date: '12/02/2022 - 8H 10',
    status: 'success',
  ),
];

List<Transactions> historyTransactions = [
  Transactions(
    id: 1,
    identifier: '87489568548235',
    phone: '+221 77 715 86 73',
    wallet: walletsSenegal.first,
    amount: 1000,
    date: '12/02/2022 - 8H 10',
    status: 'success',
  ),
  Transactions(
    id: 2,
    identifier: '87489568548235',
    phone: '+221 77 715 86 73',
    wallet: walletsSenegal.first,
    amount: 1000,
    date: '12/02/2022 - 8H 10',
    status: 'failed',
  ),
  Transactions(
    id: 3,
    identifier: '87489568548235',
    phone: '+221 77 715 86 73',
    wallet: walletsSenegal.first,
    amount: 1000,
    date: '12/02/2022 - 8H 10',
    status: 'success',
  ),
  Transactions(
    id: 4,
    identifier: '87489568548235',
    phone: '+221 77 715 86 73',
    wallet: walletsSenegal.first,
    amount: 1000,
    date: '12/02/2022 - 8H 10',
    status: 'success',
  ),
  Transactions(
    id: 5,
    identifier: '87489568548235',
    phone: '+221 77 715 86 73',
    wallet: walletsSenegal.first,
    amount: 1000,
    date: '12/02/2022 - 8H 10',
    status: 'success',
  ),
  Transactions(
    id: 6,
    identifier: '87489568548235',
    phone: '+221 77 715 86 73',
    wallet: walletsSenegal.first,
    amount: 1000,
    date: '12/02/2022 - 8H 10',
    status: 'success',
  ),
  Transactions(
    id: 7,
    identifier: '87489568548235',
    phone: '+221 77 715 86 73',
    wallet: walletsSenegal.first,
    amount: 1000,
    date: '12/02/2022 - 8H 10',
    status: 'success',
  ),
  Transactions(
    id: 8,
    identifier: '87489568548235',
    phone: '+221 77 715 86 73',
    wallet: walletsSenegal.first,
    amount: 1000,
    date: '12/02/2022 - 8H 10',
    status: 'success',
  ),
]; */
