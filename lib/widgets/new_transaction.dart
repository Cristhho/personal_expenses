import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  void submitData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if(title.isNotEmpty && amount >= 0) {
      addNewTransaction(title, amount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(decoration: InputDecoration(
                labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) {submitData();},
            ),
            TextField(decoration: InputDecoration(
                labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) {submitData();},
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
