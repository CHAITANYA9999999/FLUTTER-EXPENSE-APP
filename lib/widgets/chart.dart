import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransacition;
  Chart(this.recentTransacition);

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

  List<String> s = ['df', 'sdf'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.38,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Column(
          children: groupedTransactionValue.map((data) {
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
        ),
      ),
    );
  }
}


//to reverse the order of the list is