import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(id: 't1', title: 'New shoes', amount: 69.99, date: DateTime.now()),
    Transaction(id: 't2', title: 'Weekly groceries', amount: 20.30, date: DateTime.now())
  ];

  void _addNewTransaction(String newTitle, double newAmount) {
    final newTrs = Transaction(title: newTitle, amount: newAmount,
        date: DateTime.now(), id: DateTime.now().toString());

    setState(() {
      _transactions.add(newTrs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_transactions)
      ],
    );
  }
}
