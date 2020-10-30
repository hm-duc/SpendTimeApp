import 'package:flutter/widgets.dart';

class Transaction {
  final String title;
  final String id;
  final double amount;
  final DateTime date;

  const Transaction({
    @required this.title,
    @required this.id,
    @required this.amount,
    @required this.date,
  });
}
