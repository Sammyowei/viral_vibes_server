// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: sort_constructors_first, avoid_unused_constructor_parameters, use_setters_to_change_properties, lines_longer_than_80_chars

import 'dart:math';

import 'order_model.dart';
import 'transaction_model.dart';

class User {
  User({
    required this.userName,
    required this.emailAddress,
    required this.mobileNumber,
    required this.password,
    required this.passwordSalt,
    this.referee,
    DateTime? createdAt,
    String? referalCode,
    this.isReferred = false,
    this.isVerified = false,
    this.orderHistory = const [],
    this.transactionHistory = const [],
    this.totalReferals = 0,
    this.totalSpent = 0,
    this.totalTransaction = 0,
    this.walletBalance = 0,
  })  : _createdAt = createdAt ?? DateTime.now(),
        _referalCode = referalCode ?? _generateReferralCode(userName);

  final String userName;
  final String emailAddress;
  final String mobileNumber;
  String password;
  bool isVerified;

  bool isReferred;

  final String _referalCode;

  final String? referee;
  final String passwordSalt;
  final DateTime _createdAt;

  int totalTransaction;
  int totalReferals;
  double totalSpent;
  double walletBalance;
  List<OrderModel> orderHistory;
  List<Transactions> transactionHistory;

  void updatePassword(String newPassword) {
    password = newPassword;
  }

  void updateReferals() {
    totalReferals = totalReferals + 1;
  }

  void withraw(double amount) {
    walletBalance = walletBalance - amount;
  }

  void verifyAccount() {
    isVerified = true;
  }

  void deposit(double amount) {
    walletBalance = walletBalance + amount;
  }

  void addOrder(OrderModel order) {
    orderHistory.add(order);
  }

  void addTransaction(Transactions transaction) {
    transactionHistory.add(transaction);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    final dynamicOrderHistoryJson = json['orderHistory'] as List<dynamic>;
    final dynamicTransactionHistoryJson =
        json['transactionHistory'] as List<dynamic>;

    final orderHistory = <Map<String, dynamic>>[];
    final transactionHistory = <Map<String, dynamic>>[];

    dynamicTransactionHistoryJson.forEach(
      (element) {
        if (element is Map<String, dynamic>) {
          transactionHistory.add(element);
        }
      },
    );

    dynamicOrderHistoryJson.forEach(
      (element) {
        if (element is Map<String, dynamic>) {
          orderHistory.add(element);
        }
      },
    );

    return User(
      userName: json['userName'] as String,
      emailAddress: json['emailAddress'] as String,
      mobileNumber: json['mobileNumber'] as String,
      isVerified: json['isVerified'] as bool,
      isReferred: json['isReferred'] as bool,
      referalCode: json['referalCode'] as String,
      referee: json['referee'] as String?,
      walletBalance: json['walletBalance'] as double,
      password: json['password'] as String,
      passwordSalt: json['passwordSalt'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      totalTransaction: json['totalTransaction'] as int,
      totalReferals: json['totalReferals'] as int,
      totalSpent: json['totalSpent'] as double,
      orderHistory: orderHistory.map(OrderModel.fromJson).toList(),
      transactionHistory:
          transactionHistory.map(Transactions.fromJson).toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'emailAddress': emailAddress,
      'mobileNumber': mobileNumber,
      'password': password,
      'isVerified': isVerified,
      'isReferred': isReferred,
      'referalCode': _referalCode,
      'referee': referee,
      'passwordSalt': passwordSalt,
      'createdAt': _createdAt.toIso8601String(),
      'totalTransaction': totalTransaction,
      'totalReferals': totalReferals,
      'totalSpent': totalSpent,
      'walletBalance': walletBalance,
      'orderHistory': orderHistory.map((e) => e.toJson()).toList(),
      'transactionHistory': transactionHistory.map((e) => e.toJson()).toList(),
    };
  }
}

String _generateReferralCode(String username) {
  // Generate a random alphanumeric value of length 4
  final randomValue = _generateRandomValue();

  // Format the referral code
  final referralCode = '$username-$randomValue-VIBER';
  return referralCode;
}

String _generateRandomValue() {
  const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  final stringBuffer = StringBuffer();

  for (var i = 0; i < 4; i++) {
    stringBuffer.write(characters[random.nextInt(characters.length)]);
  }

  return stringBuffer.toString();
}
