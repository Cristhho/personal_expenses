import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _transactions.map((trs) {
        return Card(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2)
                ),
                padding: (
                    EdgeInsets.all(10.0)
                ),
                child: Text(
                  '\$${trs.amount}',
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 20.0, color: Colors.purple),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(trs.title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  Text(DateFormat('yyyy-MM-dd').format(trs.date),
                      style: TextStyle(fontSize: 14.0, color: Colors.grey)
                  )
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
