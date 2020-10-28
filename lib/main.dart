import 'package:course_4/widgets/chart.dart';
import 'package:course_4/widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'model/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'QuickSand',
          primarySwatch: Colors.red,
          textTheme: TextTheme(
            bodyText1: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold),
            bodyText2: TextStyle(
                fontFamily: 'OpenSans', fontSize: 14, color: Colors.grey),
          ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void startAddTrans(BuildContext ct) {
    showModalBottomSheet(
        context: ct,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  final List<Transaction> _transacions = [];

  List<Transaction> get _listTransactions {
    return _transacions.where((el) {
      return el.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String txTitlte, double txAmount) {
    final _newTrans = Transaction(
        title: txTitlte,
        id: DateTime.now().toString(),
        amount: txAmount,
        date: DateTime.now());

    setState(() {
      _transacions.add(_newTrans);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Bar',
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddTrans(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(_listTransactions),
            TransactionList(
              transacions: _transacions,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddTrans(context),
      ),
    );
  }
}
