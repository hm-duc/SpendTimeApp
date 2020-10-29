import 'package:course_4/widgets/chart.dart';
import 'package:course_4/widgets/new_transaction.dart';
import 'package:flutter/services.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'model/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'QuickSand',
          errorColor: Colors.red,
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
              bodyText1: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              bodyText2: TextStyle(
                  fontFamily: 'OpenSans', fontSize: 14, color: Colors.grey),
              button: TextStyle(color: Colors.white)),
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

  void _addTransaction(
      String txTitlte, double txAmount, DateTime transactionDate) {
    final _newTrans = Transaction(
        title: txTitlte,
        id: DateTime.now().toString(),
        amount: txAmount,
        date: transactionDate);

    setState(() {
      _transacions.add(_newTrans);
    });
  }

  void _deleteTransaction(String id) {
    if (id != null) {
      setState(() {
        _transacions.removeWhere((element) {
          return element.id == id;
        });
      });
    }
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    var _appBar = AppBar(
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
    );
    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Chart!'),
                Switch(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                )
              ],
            ),
            _showChart ? Container(
              child: Chart(_listTransactions),
              height: (MediaQuery.of(context).size.height -
                      _appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.25,
            ) : Container(
              child: TransactionList(
                transacions: _transacions,
                deleteTransaction: _deleteTransaction,
              ),
              height: (MediaQuery.of(context).size.height -
                      _appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.75,
            ),
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
