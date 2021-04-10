import 'package:expenses/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.indigo,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline5: TextStyle(
                  fontFamily: 'Montserrat',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
              bodyText2: TextStyle(
                  fontFamily: 'Montserrat',
                  fontStyle: FontStyle.italic,
                  fontSize: 12),
            ),
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[50],
            textTheme: ThemeData.light()
                .textTheme
                .copyWith(headline6: TextStyle(fontFamily: 'Montserrat')),
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor)),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'food',
    //   amount: 59.19,
    //   date: DateTime.now(),
    // )
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 150,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
        title: Text(
          'Expenses',
          style: TextStyle(
              fontSize: 40,
              foreground: Paint()
                ..shader = ui.Gradient.linear(
                  const Offset(0, 20),
                  const Offset(150, 20),
                  <Color>[
                    Colors.red,
                    Colors.blue,
                  ],
                )),
        ),
        elevation: 0,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chart(_recentTransactions),
            ],
          ),
          Container(
            child: TransactionList(_userTransactions),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
