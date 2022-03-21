import 'package:box_app/models/user.dart';
import 'package:box_app/models/wallet.dart';

class Application {
  final int id;
  final String name;
  final String description;
  final String accountNumber;
  final String slug;
  final String webSite;
  final String livePublickey;
  final String livePrivateKey;
  final String liveToken;
  final String testPublicKey;
  final String testPrivateKey;
  final String testToken;
  final User user;
  final List<Wallet> wallets;
  final Wallet withdrawWallet;

  Application({
    this.id,
    this.name,
    this.description,
    this.accountNumber,
    this.slug,
    this.webSite,
    this.livePublickey,
    this.livePrivateKey,
    this.liveToken,
    this.testPublicKey,
    this.testPrivateKey,
    this.testToken,
    this.user,
    this.wallets,
    this.withdrawWallet,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    try {
      return Application(
        id: json['id'] as int,
        name: json['app_name'] as String,
        description: json['description'] as String,
        slug: json['slug'] as String,
        webSite: json['website_url'] as String,
        testPrivateKey: json['test_private_key'] as String,
        testPublicKey: json['test_public_key'] as String,
        testToken: json['test_token'] as String,
        livePrivateKey: json['live_private_key'] as String,
        livePublickey: json['live_public_key'] as String,
        liveToken: json['live_token'] as String,
        accountNumber: json['account_number'] as String,
        user: User.fromJson(json['user']),
        wallets: walletsFromListJson(json["active_channels"]),
        withdrawWallet: json['withdraw_channel'] != null
            ? Wallet.fromJson(json['withdraw_channel'])
            : walletsSenegal.first,
      );
    } catch (e) {
      throw e;
    }
  }
}
