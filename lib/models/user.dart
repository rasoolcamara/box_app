import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:box_app/models/caterer.dart';
// import 'package:box_app/models/customer.dart';
// import 'package:box_app/models/setting.dart';

class User {
  int id;
  String name;
  String phone;
  String phoneWithIndicatif;
  String email;
  String balance;
  String masterKey;
  String token;
  String clientToken;

  User({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.phoneWithIndicatif,
    this.token,
    this.clientToken,
    this.balance,
    this.masterKey,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      phoneWithIndicatif: json['phone_with_indicatif'] as String,
      balance: json['balance'] as String,
      email: json['email'] as String,
      masterKey: json['master_key'] as String,
      token: json['token'] as String,
      clientToken: json['client_token'] as String,
    );
  }
}
