import 'package:flutter/foundation.dart';

class Transaction {
  // String id = DateTime.now().toString();
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  // Transaction(title, amount, date) {
  //   Transaction({
  //     this.id = id,
  //     required this.title,
  //     required this.amount,
  //     required this.date,
  //   });
  // }

// String get id => this.id;
  // String get title => this.title;
  // String get amount => this.amount;
  // DateTime get date => this.date;
  //
  

}
