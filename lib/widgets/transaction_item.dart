import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transactions,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transactions;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgcolor;

  @override
  void initState() {
    // TODO: implement initState
    const availableColor = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.black,
    ];

    _bgcolor = availableColor[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: _bgcolor,
            radius: 30,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(
                  child: Text(
                '\$${widget.transactions.amount}',
              )),
            )),
        title: Text(
          widget.transactions.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(widget.transactions.date),
        ),
        trailing: IconButton(
          //I coded it by myself
          // onPressed: (() => RemoveTransaction(index)),

          onPressed: () => widget.deleteTx(widget.transactions.id),
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),

          //!THIS WAS NOT NECESSARY
          // style: ButtonStyle(
          //     backgroundColor:
          //         MaterialStateProperty.all(Colors.white),
          //     foregroundColor:
          //         MaterialStateProperty.all(Colors.black)),
        ),
      ),
    );
  }
}
