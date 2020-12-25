import 'package:flutter/foundation.dart';

class Transaction {
  final DateTime date;
  final double amount;
  final String title;
  final String id;

  Transaction({
    @required this.date,
    @required this.amount,
    @required this.id,
    @required this.title,
  });
}
