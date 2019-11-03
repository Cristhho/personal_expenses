import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    : ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(
                  child: Text('\$${_transactions[index].amount}')
                ),
              ),
            ),
            title: Text(
              _transactions[index].title,
              style: Theme.of(context).textTheme.title,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(_transactions[index].date)
            ),
            trailing: MediaQuery.of(context).size.width < 360 ?
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {deleteTransaction(_transactions[index].id);},
            ) :
            FlatButton.icon(
              icon: const Icon(Icons.delete),
              label: const Text('Delete'),
              textColor: Theme.of(context).errorColor,
              onPressed: () {deleteTransaction(_transactions[index].id);},
            )
          ),
        );
      },
      itemCount: _transactions.length,
    );
  }
}
