import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';
import './user_transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      //Since ListView is scrollable, it takes infinite height, so therefore we cannot
      //use it without container, we have to give it a height
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
              child: Row(
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.purple,
                    width: 2,
                  )),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '\$${transactions[index].amount}', //this is called string interpolation, \ means escaping
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.lightGreen,
                    ),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactions[index].title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMEd().format(transactions[index].date),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              )
            ],
          ));
        },
        itemCount: transactions.length,
      ),
    );
  }
}


//listview makes the column scrollable and we give the childrens, but when the list is large
//we do not render all the items at the same time, the items which are not displayed at the
//time are not rendered to save memory, therefore we use listview.builder which only
//builds those items which are to be displayed on the screen