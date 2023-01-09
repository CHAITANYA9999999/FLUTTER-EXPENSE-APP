import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'NIKE AIR JORDAN 1',
      amount: 987.65,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'IPHONE 13',
      amount: 599.99,
      date: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                elevation: 10,
                child: Text('Chart!'),
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'TITLE',
                        hintText: 'Enter Title',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        hintText: 'Enter Amount',
                      ),
                    ),
                    TextButton(
                        onPressed: null,
                        child: Text(
                          "Add Transaction",
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Column(
              children: transactions.map(
                (tx) {
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
                            '\$${tx.amount}', //this is called string interpolation, \ means escaping
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
                            tx.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMEd().format(tx.date),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ));
                },
              ).toList(),
            )
          ],
        ));
  }
}
