import 'dart:io';
import 'package:course_4/widgets/chart.dart';
import 'package:course_4/widgets/new_transaction.dart';
import 'package:flutter/cupertino.dart';
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
    final mediaQuery = MediaQuery.of(context);
    final isIOS = Platform.isIOS;
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget _appBar = isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'App Bar',
              style: TextStyle(fontFamily: 'OpenSans'),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => startAddTrans(context),
                )
              ],
            ),
          )
        : AppBar(
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

    final txListWidget = Container(
      child: TransactionList(
        transacions: _transacions,
        deleteTransaction: _deleteTransaction,
      ),
      height: (mediaQuery.size.height -
              _appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.75,
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart!',style: Theme.of(context).textTheme.bodyText1,),
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
            if (!isLandscape)
              Container(
                child: Chart(_listTransactions),
                height: (mediaQuery.size.height -
                        _appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.25,
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      child: Chart(_listTransactions),
                      height: (mediaQuery.size.height -
                              _appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                    )
                  : txListWidget
          ],
        ),
      ),
    );

    return isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
          )
        : Scaffold(
            appBar: _appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => startAddTrans(context),
                  ),
          );
  }
}
