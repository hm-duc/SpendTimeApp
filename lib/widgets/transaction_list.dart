import 'package:flutter/material.dart';
import 'package:course_4/model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transacions;
  final Function deleteTransaction;

  TransactionList({this.transacions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return transacions.isEmpty
        ? LayoutBuilder(builder: (ctx,contrains) {
          return Column(
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
                height: contrains.maxHeight * 0.6,
              )
            ],
          );
        },)
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: FittedBox(
                      child: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text('\$${transacions[index].amount}')),
                    ),
                  )),
                  title: Text(
                    transacions[index].title,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: Text(DateFormat.yMMMMd().format(
                    transacions[index].date,
                  )),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () => deleteTransaction(transacions[index].id),
                  ),
                ),
              );
            },
            itemCount: transacions.length,
          );
  }
}
