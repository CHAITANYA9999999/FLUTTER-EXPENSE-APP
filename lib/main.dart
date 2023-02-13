//*PIXEL 3a
import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/new_transaction_.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './model/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          fontFamily: 'QuickSand',
          primarySwatch: Colors.cyan,
          accentColor: Colors.amber,
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              button:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          appBarTheme: const AppBarTheme(
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
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
  //     dte: DateTime.now(),
  //   ),
  // ];

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  //*this will be executed when the lifecycle is changed for the app
  //*lifecycle as in paused when running in the background
  //*or resumed when app is started again from the background
  //*or suspended when app is about to be exited due to external factors like low battery
  //*or inactive when app is not even runnning in the background
  //*and also this should be before all the functions are initialised
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    // super.didChangeAppLifecycleState(state);
    print(state);
  }

  //*it means that whenever the lifecycle is changed for the app
  //*it will remove the listener(user info) for the user to aviod memory leaks
  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final List<Transaction> _userTransaction = [
    Transaction(
        id: 'id',
        title: 'AIR JORDAN',
        amount: 479.56,
        date: DateTime.now().subtract(Duration(days: 5)))
  ];

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  //* late String titleInput;
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: (() {}),
            behavior: HitTestBehavior.translucent,
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  void _deleteTransaction(String txId) {
    for (var i = 0; i < _userTransaction.length; i++) {
      print('${_userTransaction[i].title} ${_userTransaction[i].id}}');
    }
    setState(() {
      _userTransaction.removeWhere(((element) {
        return (element.id == txId);
      }));
    });
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text(
        'Daily Expense App',
        style: TextStyle(fontFamily: 'Open Sans'),
      ),
      actions: [
        IconButton(
            onPressed: (() => {_startAddNewTransaction(context)}),
            icon: Icon(Icons.add))
      ],
    );
    return Scaffold(
      // bottomNavigationBar:
      //     BottomNavigationBar(items: const <BottomNavigationBarItem>[]),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text('Show Chart!'),
            //     Switch(
            //         value: _showChart,
            //         onChanged: ((val) {
            //           setState(() {
            //             _showChart = val;
            //           });
            //         })),
            //   ],
            // ),
            appBar,
            Container(

                //*WHAT THIS STATEMENT DID IS IT CALCULATED THE AVAILABLE HEIGHT FOR US
                //*BY SUBTRACTING THE TOTAL DEVICE HEIGHT BY THE HEIGHT OF APP BAR AND
                //* AND THE HEIGHT OF NOTIFICATION BAR(WHERE BATTERY AND STUFF IS DISPLAYED)
                //* OUT OF THAT, 43% IS ASSIGNED TO CHART AND THE REMAINING TO TRANSACTION LIST
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.5,
                child: Chart(_recentTransaction)),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.5,
                child: TransactionList(_recentTransaction, _deleteTransaction)),
          ],
        ),
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
