import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  void RemoveTransaction(int index) {
    setState(() {
      widget.transactions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      //Since ListView is scrollable, it takes infinite height, so therefore we cannot
      //use it without container, we have to give it a height
      child: (this.widget.transactions.isEmpty)
          ? Column(
              children: [
                Text(
                  'No Transactions Yet Added',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                          child:
                              Text('\$${widget.transactions[index].amount}'))),
                );
                // return Card(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Container(
                //         child: Row(
                //           children: [
                //             Container(
                //                 margin: EdgeInsets.symmetric(
                //                   vertical: 10,
                //                   horizontal: 15,
                //                 ),
                //                 decoration: BoxDecoration(
                //                     border: Border.all(
                //                   color: Theme.of(context).primaryColorDark,
                //                   width: 2,
                //                 )),
                //                 padding: EdgeInsets.all(10),
                //                 child: Text(
                //                   '\$${widget.transactions[index].amount}', //this is called string interpolation, \ means escaping
                //                   style: TextStyle(
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 20,
                //                     color: Theme.of(context).primaryColor,
                //                   ),
                //                 )),
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   widget.transactions[index].title,
                //                   style: Theme.of(context).textTheme.headline6,
                //                 ),
                //                 Text(
                //                   DateFormat.yMMMEd()
                //                       .format(widget.transactions[index].date),
                //                   style: const TextStyle(color: Colors.grey),
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //       TextButton(
                //         onPressed: (() => RemoveTransaction(index)),
                //         child: Icon(
                //           Icons.delete,
                //           color: Colors.red,
                //         ),
                //         style: ButtonStyle(
                //             backgroundColor:
                //                 MaterialStateProperty.all(Colors.white),
                //             foregroundColor:
                //                 MaterialStateProperty.all(Colors.black)),
                //       )
                //     ],
                //   ),
                // );
              },
              itemCount: widget.transactions.length,
            ),
    );
  }
}

//*listview makes the column scrollable and we give the childrens, but when the list is large
//*we do not render all the items at the same time, the items which are not displayed at the
//*time are not rendered to save memory, therefore we use listview.builder which only
//*builds those items which are to be displayed on the screen