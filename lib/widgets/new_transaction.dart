import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  //const NewTransaction({Key key}) //: super(key: key);

  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    //close the popup
    Navigator.of(context).pop();
  }

  Future _presentDatePicker() async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
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
              controller: _titleController,
              onSubmitted: (_) => _submitData,
              //  onChanged: (value) => { },
              // onChanged: (val) => _titleInput = val,
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),

              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              onSubmitted: (_) => _submitData,
              // onChanged: (val) => _amountInput = val,
            ),
            Container(
              height: 70,
              child: Row(children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'No date choosen'
                      : 'Picked Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
                ),
                FlatButton(
                    onPressed: _presentDatePicker, //() {},
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ]),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: RaisedButton(
                onPressed: _submitData,
                child: Text('Add transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
