import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import './user_transactions.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  Function addTx;
  NewTransaction(this.addTx);

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    addTx(titleController.text, double.parse(amountController.text));
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
