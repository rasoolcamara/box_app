import 'package:box_app/app_properties.dart';

class Wallet {
  final int id;
  final String name;
  final String logo;
  final String slug;
  final String scope;
  final int isActive;
  final String status;

  Wallet({
    this.id,
    this.name,
    this.logo,
    this.slug,
    this.scope,
    this.isActive,
    this.status,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String,
      slug: json['slug'] as String,
      scope: json['scope'] as String,
      isActive: json['is_active'] as int,
      status: json['status'] as String,
    );
  }
}

List<Wallet> walletsFromListJson(List<dynamic> json) {
  List<Wallet> wallets = json
      .map(
        (dynamic item) => Wallet.fromJson(item),
      )
      .toList();
  return wallets;
}

Wallet walletsFromSlug(String item) {
  String val = item.replaceAll('_', "-");

  List<Wallet> wallets = activeApplication.wallets.where((Wallet wallet) {
    // print("test 22");
    // print(wallet.slug);
    // print("test 22");
    // print(val);
    val = "orange-money-senegal";
    return wallet.slug == val;
  }).toList();

  Wallet wallet =
      wallets.isNotEmpty ? wallets.first : activeApplication.wallets.first;

  return wallet;
}

List<Wallet> walletsSenegal = [
  Wallet(
    id: 1,
    // providerId: 1,
    name: "Orange Money",
    logo: 'assets/images/logo-part/orange-money.png',
    status: 'active',
  ),
  Wallet(
    id: 2,
    // providerId: 1,
    name: "Wave",
    logo: 'assets/images/logo-part/wave.png',
    status: 'active',
  ),
  Wallet(
    id: 3,
    // providerId: 1,
    name: "Free Money",
    logo: 'assets/images/logo-part/free-money.png',
    status: 'active',
  ),
  Wallet(
    id: 4,
    // providerId: 1,
    name: "WizAll Money",
    logo: 'assets/images/logo-part/wizall.png',
    status: 'active',
  ),
  Wallet(
    id: 5,
    // providerId: 1,
    name: "E Money",
    logo: 'assets/images/logo-part/emoney.png',
    status: 'active',
  ),
];

List<Wallet> walletsCI = [
  Wallet(
    id: 1,
    name: "Orange Money",
    logo: 'assets/images/logo-part/orange-money.png',
    status: 'active',
  ),
  Wallet(
    id: 2,
    name: "MTN",
    logo: 'assets/images/logo-part/mtn.png',
    status: 'active',
  ),
  Wallet(
    id: 3,
    name: "Moov",
    logo: 'assets/images/logo-part/moov.png',
    status: 'active',
  ),
];

List<Wallet> walletsBJ = [
  Wallet(
    id: 9,
    name: "MTN",
    logo: 'assets/images/logo-part/mtn.png',
    status: 'active',
  ),
  Wallet(
    id: 10,
    name: "Moov",
    logo: 'assets/images/logo-part/moov.png',
    status: 'active',
  ),
];

List<Wallet> walletsBF = [
  Wallet(
    id: 11,
    name: "Orange Money",
    logo: 'assets/images/logo-part/orange-money.png',
    status: 'active',
  ),
  // Wallet(
  //   id: 12,
  //   name: "MTN BF",
  //   logo: 'assets/images/partner_logo/mtn.png',
  //   status: 'active',
  // ),
  Wallet(
    id: 12,
    name: "Moov",
    logo: 'assets/images/logo-part/moov.png',
    status: 'active',
  ),
];

Map<String, List<Wallet>> walletsByCountry = {
  "Sénégal": walletsSenegal,
  "Cote d'ivoire": walletsCI,
  "Bénin": walletsBJ,
  "Burkina Faso": walletsBF,
};
