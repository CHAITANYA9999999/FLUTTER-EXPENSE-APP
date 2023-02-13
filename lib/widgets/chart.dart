import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransacition;
  const Chart(this.recentTransacition);

  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;
      for (var i = 0; i < recentTransacition.length; i++) {
        if (recentTransacition[i].date.day == weekDay.day &&
            recentTransacition[i].date.month == weekDay.month &&
            recentTransacition[i].date.year == weekDay.year) {
          totalSum += recentTransacition[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  // double get fraction {
  //   var sum = 0.00;
  //   for (var i = 0; i < recentTransacition.length; i++) {
  //     sum += recentTransacition[i].amount;
  //   }
  //   print(sum);
  //   return sum;
  // }

  double get maxSpending {
    return groupedTransactionValue.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        ...groupedTransactionValue.map((data) {
          return ChartBar(
            label: data['day'].toString(),
            spendingAmount: data['amount'] as double,
            spendingPercentageOfTotal: maxSpending == 0.0
                ? 0
                : ((data['amount'] as double) / maxSpending),

            // spendingPercentageOfTotal: fraction.toInt() != 0
            //      (double.parse(data['amount'].toString()) / fraction)
            //     : 0
          );
        }).toList(),
      ]),
    );
  }
}


//to reverse the order of the list is