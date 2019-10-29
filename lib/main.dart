import 'package:flutter/material.dart';

import 'widgets/chart.dart';
import 'models/transaction.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Quicksand',
        errorColor: Colors.deepOrange,
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(fontFamily: 'OpenSans', fontSize: 18),
          button: TextStyle(color: Colors.white)
        ),
        appBarTheme: AppBarTheme(textTheme: ThemeData.light()
            .textTheme.copyWith(title: TextStyle(
            fontFamily: 'OpenSans', fontSize: 16, fontWeight: FontWeight.bold
        )))
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String newTitle, double newAmount, DateTime date) {
    final newTrs = Transaction(title: newTitle, amount: newAmount,
        date: date, id: DateTime.now().toString());

    setState(() {
      _transactions.add(newTrs);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bCtx) {
          return NewTransaction(_addNewTransaction);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
          'Personal Expenses'
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => {_startAddNewTransaction(context)},
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height
                  - appBar.preferredSize.height
                  - MediaQuery.of(context).padding.top) * 0.3,
              child: Chart(_recentTransactions)
            ),
            Container(
                height: (MediaQuery.of(context).size.height
                    - appBar.preferredSize.height
                    - MediaQuery.of(context).padding.top) * 0.7,
              child: TransactionList(_transactions, _deleteTransaction)
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {_startAddNewTransaction(context)},
      ),
    );
  }
}
