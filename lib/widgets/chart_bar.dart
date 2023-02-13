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
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        // height: constraints.maxHeight / 7,
        // width: constraints.maxWidth,
        // height: ctx,
        // height: MediaQuery.of(context).size.height/7,
        child: Row(children: [
          Container(
            alignment: Alignment.center,
            width: constraints.maxWidth * 0.10,
            // height: constraints.maxHeight / 7,
            child: FittedBox(fit: BoxFit.cover, child: Text(label)),
          ),
          SizedBox(
            width: constraints.maxWidth * 0.05,
          ),
          Container(
            width: constraints.maxWidth * 0.7,
            // width: 255,
            child: Stack(
              children: [
                Container(
                  height: 15,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: spendingPercentageOfTotal,
                  child: Container(
                      height: 15,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      )),
                )
              ],
            ),
          ),
          SizedBox(
            width: constraints.maxWidth * 0.05,
          ),
          Container(
            width: constraints.maxWidth * 0.10,
            child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
          ),
        ]),
      );
    });
  }
}
