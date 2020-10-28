import 'package:course_4/model/transaction.dart';
import 'package:course_4/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get transactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      transactions.asMap().forEach((key, value) {
        if (value.date.day == weekDay.day &&
            value.date.month == weekDay.month &&
            value.date.year == weekDay.year) {
          totalSum += value.amount;
        }
      });

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return transactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: transactionValues.map((e) {
          return Flexible(
            fit: FlexFit.tight,
              child: ChartBar(
                label: e['day'],
                spendingAmount: e['amount'],
                spendingPctOfTotal: totalSpending == 0 ? 0 : (e['amount'] as double) / totalSpending),
          );
        }).toList(),
      ),
    );
  }
}
