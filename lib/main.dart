import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(id: 't1', title: 'New shoes', amount: 69.99, date: DateTime.now()),
    Transaction(id: 't2', title: 'Weekly groceries', amount: 20.30, date: DateTime.now())
  ];
//  String titleInput;
//  String amountInput;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            color: Colors.blue,
            child: Container(
              width: double.infinity,
              child: Text('CHART!'),
            ),
            elevation: 5,
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(decoration: InputDecoration(
                    labelText: 'Title'),
                    controller: titleController,
//                    onChanged: (value) {
//                    titleInput = value;},
                  ),
                  TextField(decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                  controller: amountController,
                  keyboardType: TextInputType.number,
//                  onChanged: (value) {
//                    amountInput = value;},
                  ),
                  FlatButton(
                    child: Text('Add Transaction'),
                    textColor: Colors.purple,
                    onPressed: () {
                      print(titleController.text + ' ' + amountController.text);
                    },
                  )
                ],
              ),
            ),
          ),
          Column(
            children: transactions.map((trs) {
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
          )
        ],
      )
    );
  }
}
