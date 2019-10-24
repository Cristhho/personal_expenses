import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
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
                    '\$${_transactions[index].amount}',
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 20.0, color: Colors.purple),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_transactions[index].title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    Text(DateFormat('yyyy-MM-dd').format(_transactions[index].date),
                        style: TextStyle(fontSize: 14.0, color: Colors.grey)
                    )
                  ],
                )
              ],
            ),
          );
        },
        itemCount: _transactions.length,
      ),
    );
  }
}
