import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  //Coded it by myself
  // void RemoveTransaction(int index) {
  //   setState(() {
  //     widget.transactions.removeAt(index);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      //Since ListView is scrollable, it takes infinite height, so therefore we cannot
      //use it without container, we have to give it a height
      child: (transactions.isEmpty)
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
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                              child: Text(
                            '\$${transactions[index].amount}',
                          )),
                        )),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      //I coded it by myself
                      // onPressed: (() => RemoveTransaction(index)),

                      onPressed: () => deleteTx(transactions[index].id),
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
              itemCount: transactions.length,
            ),
    );
  }
}

//*listview makes the column scrollable and we give the childrens, but when the list is large
//*we do not render all the items at the same time, the items which are not displayed at the
//*time are not rendered to save memory, therefore we use listview.builder which only
//*builds those items which are to be displayed on the screen