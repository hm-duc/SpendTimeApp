import 'package:flutter/material.dart';
import 'package:course_4/model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transacions;

  TransactionList({this.transacions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transacions.isEmpty
          ? Column(
              children: <Widget>[
                Text('Don\'t have any transactions!'),
                SizedBox(
                  height: 15,
                  
                ),
                Container(
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                  height: 200,
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: Theme.of(context).primaryColor)),
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${transacions[index].amount}',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transacions[index].title,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            DateFormat('yyyy/MM/dd')
                                .format(transacions[index].date),
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: transacions.length,
            ),
    );
  }
}
