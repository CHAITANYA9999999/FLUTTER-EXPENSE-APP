import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    DateTime? date = _selectedDate;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || date == null) {
      return;
    }

    //*this widget.add has been added by automatically when we converted
    //*it from stateles to stateful widget
    widget.addTx(enteredTitle, enteredAmount, date);

    Navigator.of(context).pop(); //the modal bottom sheet will
    //automatically close when you press add transaction
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if (datePicked == null) {
        return;
      }
      setState(() {
        _selectedDate = datePicked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'TITLE',
                hintText: 'Enter Title',
              ),
              // onChanged: (str1) {
              //   titleInput = str1;
              // },
              controller: _titleController,
              onSubmitted: ((val) => _submitData()),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                hintText: 'Enter Amount',
              ),
              keyboardType: TextInputType.number,
              // onChanged: (str2) {
              //   amountInput = str2;
              // },
              controller: _amountController,
              onSubmitted: ((val) => _submitData()),
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedDate == null
                      ? 'No Date Chosen'
                      : 'Date Picked: ${DateFormat.yMEd().format(_selectedDate!)}'),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).textTheme.button?.color),
                ),
                onPressed: _submitData,
                child: Text(
                  "Add Transaction",
                ))
          ],
        ),
      ),
    );
  }
}
