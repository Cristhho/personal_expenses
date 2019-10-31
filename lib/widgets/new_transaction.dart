import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if(title.isNotEmpty && amount >= 0 && _selectedDate != null) {
      widget.addNewTransaction(title, amount, _selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _presentDayPicker() {
    showDatePicker(context: context, initialDate: DateTime.now(),
      firstDate: DateTime(2019), lastDate: DateTime.now(),)
      .then((pickedDate) {
        if(pickedDate == null) {
          return;
        } else {
          setState(() {
            _selectedDate = pickedDate;
          });
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(decoration: InputDecoration(
                  labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) {_submitData();},
              ),
              TextField(decoration: InputDecoration(
                  labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) {_submitData();},
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(_selectedDate == null ? 'No date chosen' : 'Selected date: ' + DateFormat.yMd().format(_selectedDate))
                    ),
                    AdaptiveFlatButton('Choose date', _presentDayPicker)
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
