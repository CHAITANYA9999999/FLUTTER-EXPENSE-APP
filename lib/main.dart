import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/new_transaction_.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './model/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          fontFamily: 'QuickSand',
          primarySwatch: Colors.cyan,
          accentColor: Colors.amber,
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
          // appBarTheme: AppBarTheme(
          //   textTheme: ThemeData.light().textTheme.copyWith(
          //           headline6: TextStyle(
          //         fontFamily: 'Open Sans',
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold,
          //       )),
          // )
          ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final List<Transaction> _userTransaction = [
  //   Transaction(
  //     id: 't1',
  //     title: 'Nike Air Jordan 1',
  //     amount: 987.65,
  //     date: DateTime.now(),
  //   ),
  //   Transaction(
  //     id: 't2',
  //     title: 'iPhone 13',
  //     amount: 599.99,
  //     date: DateTime.now(),
  //   ),
  // ];

  final List<Transaction> _userTransaction = [];

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  // late String titleInput;
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: (() {}),
            behavior: HitTestBehavior.translucent,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily Expense App',
          style: TextStyle(fontFamily: 'Open Sans'),
        ),
        actions: [
          IconButton(
              onPressed: (() => {_startAddNewTransaction(context)}),
              icon: Icon(Icons.add))
        ],
      ),
      // bottomNavigationBar:
      //     BottomNavigationBar(items: const <BottomNavigationBarItem>[]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Chart(_recentTransaction),
          TransactionList(_userTransaction),
        ],
      ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (() => {_startAddNewTransaction(context)}),
      ),
    );
  }
}
