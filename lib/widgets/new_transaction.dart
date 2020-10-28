import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enterTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);
    if(enterTitle.isEmpty || enterAmount <= 0) return;
    widget.addTransaction(enterTitle, enterAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              onSubmitted: (_) => submitData(),
              keyboardType: TextInputType.number,
            ),
            FlatButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () => submitData(),
            ),
          ],
        ),
      ),
    );
  }
}
