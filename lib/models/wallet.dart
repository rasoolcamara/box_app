import 'package:box_app/app_properties.dart';

class Wallet {
  int id;
  String name;
  String logo = 'assets/images/logo-part/wave.png';
  String slug;
  String scope;
  int isActive;
  String status;

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
  List<Wallet> wallets = json.map(
    (dynamic item) {
      // print(item);
      Wallet wallet = Wallet.fromJson(item);
      wallet.logo =
          walletsLogo[wallet.slug] ?? "assets/images/logo-part/wave.png";
      walletsByCountry[wallet.scope.toUpperCase()].add(wallet);
      return wallet;
    },
  ).toList();

  // print("walletsByCountry");
  // print(walletsByCountry);

  wallets = wallets.where((Wallet wallet) {
    return wallet.scope == currentCoutry.toLowerCase();
  }).toList();

  // print("wallets.length");
  // print(wallets);

  return wallets;
}

Wallet walletsFromSlug(String item) {
  String val = item.replaceAll('_', "-");
  print(activeApplication.wallets.length);

  Wallet wallet = activeApplication.wallets.firstWhere(
    (Wallet wallet) => wallet.slug == item,
    orElse: () => activeApplication.wallets.first,
  );

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
