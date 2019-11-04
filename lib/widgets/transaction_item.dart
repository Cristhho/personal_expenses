import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required Transaction transaction,
    @required this.deleteTransaction,
  }) : _transaction = transaction, super(key: key);

  final Transaction _transaction;
  final Function deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  Color _bgColor;

  @override
  Widget build(BuildContext context) {
    return Card(

      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: _bgColor,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                  child: Text('\$${widget._transaction.amount}')
              ),
            ),
          ),
          title: Text(
            widget._transaction.title,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
              DateFormat.yMMMd().format(widget._transaction.date)
          ),
          trailing: MediaQuery.of(context).size.width < 360 ?
          IconButton(
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: () {widget.deleteTransaction(widget._transaction.id);},
          ) :
          FlatButton.icon(
            icon: const Icon(Icons.delete),
            label: const Text('Delete'),
            textColor: Theme.of(context).errorColor,
            onPressed: () {widget.deleteTransaction(widget._transaction.id);},
          )
      ),
    );
  }

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.purple];
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }
}