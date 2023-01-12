import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransacition;
  Chart(this.recentTransacition);

  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0;
      for (var i = 0; i < recentTransacition.length; i++) {
        if (recentTransacition[i].date.day == weekDay.day &&
            recentTransacition[i].date.month == weekDay.year &&
            recentTransacition[i].date.day == weekDay.year) {
          totalSum += recentTransacition[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Column(
        children: groupedTransactionValue.map((data) {
          return Text('${data['day']}: ${data['amount']}');
        }).toList(),
      ),
    );
  }
}
