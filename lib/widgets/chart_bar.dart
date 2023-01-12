import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  ChartBar(
      {required this.label,
      required this.spendingAmount,
      required this.spendingPercentageOfTotal});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 10,
          width: 60,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text('\$${spendingAmount.toStringAsFixed(0)}'),
      ],
    );
  }
}
