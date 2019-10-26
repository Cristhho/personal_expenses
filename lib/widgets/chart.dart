import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for(var i = 0; i < recentTransactions.length; i++) {
        if(recentTransactions[i].date.day == weekDay.day
            && recentTransactions[i].date.month == weekDay.month
            && recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay).substring(0, 1), 'amount': totalSum};
    });
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            double percent = 0;
            if(maxSpending > 0) {
              percent = (data['amount'] as double) / maxSpending;
            }
            return Flexible(
              fit: FlexFit.loose,
              child: ChartBar(data['day'], data['amount'], percent)
            );
          }).toList(),
        ),
      ),
    );
  }
}
