import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(date: DateTime.now(), amount: 700, id: "t1", title: "Shoes"),
    Transaction(date: DateTime.now(), amount: 500, id: "t2", title: "Mouse"),
  ];
  void _addTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        date: DateTime.now(),
        amount: txAmount,
        id: DateTime.now().toString(),
        title: txTitle);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(onPresssed:_addTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
