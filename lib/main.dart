import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            child: Text('LIST'),
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
                        '\$' + trs.amount.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 20.0, color: Colors.purple),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(trs.title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                        Text(trs.date.toString(), style: TextStyle(fontSize: 14.0, color: Colors.grey))
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
