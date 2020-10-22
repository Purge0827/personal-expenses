import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  //const NewTransaction({Key key}) //: super(key: key);

  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount);

    //close the popup
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData,
              // onChanged: (val) => _titleInput = val,
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),

              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              onSubmitted: (_) => submitData,
              // onChanged: (val) => _amountInput = val,
            ),
            FlatButton(
              onPressed: submitData,
              child: Text('Add transaction'),
              color: Colors.purple,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
