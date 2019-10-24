import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

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
            ),
            TextField(decoration: InputDecoration(
                labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: () {
                if(titleController.text.isNotEmpty
                    && amountController.text.isNotEmpty) {
                  addNewTransaction(titleController.text, double.tryParse(amountController.text));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
