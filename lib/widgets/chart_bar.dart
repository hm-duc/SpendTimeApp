import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar({this.label, this.spendingAmount, this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, conttrains) {
        return Column(
          children: <Widget>[
            Container(
                height: conttrains.maxHeight * 0.15,
                child: FittedBox(
                    child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
            SizedBox(
              height: conttrains.maxHeight * 0.05,
            ),
            Container(
              height: conttrains.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Color.fromRGBO(225, 225, 225, 1)),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                  ),
                  FractionallySizedBox(
                      heightFactor: spendingPctOfTotal,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: conttrains.maxHeight * 0.05,
            ),
            Container(
              child: FittedBox(child: Text(label)),
              height: conttrains.maxHeight * 0.15,
            )
          ],
        );
      },
    );
  }
}
