import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
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

    //this widget.add has been added by automatically when we converted
    //it from stateles to stateful widget
    widget.addTx(enteredTitle, enteredAmount);

    Navigator.of(context).pop(); //the modal bottom sheet will
    //automatically close when you press add transaction
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
              controller: titleController,
              onSubmitted: ((val) => submitData()),
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
                controller: amountController,
                onSubmitted: ((val) => submitData())),
            TextButton(
                onPressed: submitData,
                child: const Text(
                  "Add Transaction",
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
