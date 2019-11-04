import 'package:flutter/material.dart';

import 'transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function deleteTransaction;

  TransactionList(this._transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty ?
    LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Text(
              "No transactions added yet",
              style: Theme.of(context).textTheme.title,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: constraints.maxHeight * 0.6,
                child: Image.asset("assets/img/waiting.png", fit: BoxFit.cover,)
            )
          ],
        );
      }
    )
    : ListView(
      children: _transactions.map((transaction) => TransactionItem(
          transaction: transaction,
          key: ValueKey(transaction.id),
          deleteTransaction: deleteTransaction,
        )).toList()
    );
  }
}
