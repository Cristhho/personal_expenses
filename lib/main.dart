import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
  bool _showChart = false;
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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS ? CupertinoNavigationBar(
      middle: Text(
          'Personal Expenses'
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () => {_startAddNewTransaction(context)},
            child: Icon(CupertinoIcons.add),
          )
        ],
      ),
    ) : AppBar(
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
    final listWidget = Container(
      height: (mediaQuery.size.height
          - appBar.preferredSize.height
          - mediaQuery.padding.top) * 0.7,
      child: TransactionList(_transactions, _deleteTransaction)
    );
    final pageBody = SafeArea(child: SingleChildScrollView(
      child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if(isLandscape) Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Show Chart', style: Theme.of(context).textTheme.title,),
              Switch.adaptive(activeColor: Theme.of(context).accentColor,
                  value: _showChart, onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  })
            ],
          ),
          if(!isLandscape)
            Container(
                height: (mediaQuery.size.height
                    - appBar.preferredSize.height
                    - mediaQuery.padding.top) * 0.3,
                child: Chart(_recentTransactions)
            ),
          if(!isLandscape)
            listWidget,
          if(isLandscape)
            _showChart ? Container(
                height: (mediaQuery.size.height
                    - appBar.preferredSize.height
                    - mediaQuery.padding.top) * 0.6,
                child: Chart(_recentTransactions)
            ) :
            listWidget
        ],
      ),
    ));
    return Platform.isIOS ?
    CupertinoPageScaffold(
      child: pageBody,
      navigationBar: appBar,
    ) :
    Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ?
      Container() :
      FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {_startAddNewTransaction(context)},
      ),
    );
  }
}
